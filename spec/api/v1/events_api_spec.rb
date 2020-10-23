require 'rails_helper'

RSpec.describe V1::EventsAPI, type: :request do
  let(:issue) { build(:issue_with_events) }

  describe 'GET /v1/issues/:number/events' do
    mock_authentication

    context 'when issue is found' do
      before do
        allow(Issue).to receive(:find_by).with(number: issue.number.to_s).and_return(issue)
      end

      it 'is expected to have http status OK' do
        get "/v1/issues/#{issue.number}/events"

        expect(response).to have_http_status(:ok)
      end

      it 'is expected to renders an array of event entities as JSON' do
        get "/v1/issues/#{issue.number}/events"

        expected_response = issue.events.map { |event| Entities::EventEntity.new(event) }.to_json

        expect(response.body).to eq(expected_response)
      end
    end

    context 'when issue is not found' do
      before do
        allow(Issue).to receive(:find_by).with(number: issue.number.to_s).and_return(nil)
      end

      it 'is expected to have http status NOT FOUND' do
        get "/v1/issues/#{issue.number}/events"

        expect(response).to have_http_status(:not_found)
      end

      it 'is expected to renders not found error message as JSON' do
        get "/v1/issues/#{issue.number}/events"

        expected_response = { error: "Couldn't find Issue with number #{issue.number}"}.to_json

        expect(response.body).to eq(expected_response)
      end
    end
  end

  describe 'POST /v1/events' do
    context 'when its a github ping event' do
      it 'is expected to have http status NO CONTENT' do
        post '/v1/events', headers: { 'X-GitHub-Event' => 'ping' }

        expect(response).to have_http_status(:no_content)
      end

      it 'renders an empty body' do
        post '/v1/events', headers: { 'X-GitHub-Event' => 'ping' }

        expect(response.body).to be_empty
      end
    end

    context 'when its not a github ping event' do
      let(:payload) {
        {
          'action' => EventAction.list.sample,
          'issue' => {
            'number' => Faker::Number.number,
            'title' => Faker::Lorem.sentence,
            'body' => Faker::Lorem.paragraph,
            'updated_at' => Time.zone.parse('2020-10-23 00:37:00').iso8601
          }
        }
      }

      let(:event_payload) { EventPayload.new(payload) }

      context 'when event registration result is valid' do
        it 'is expected to have http status CREATED' do
          expect_any_instance_of(EventRegistration).to receive(:call).with(event_payload).and_return(issue)

          post '/v1/events', params: payload

          expect(response).to have_http_status(:created)
        end

        it 'is expected to renders full issue entity as JSON' do
          expect_any_instance_of(EventRegistration).to receive(:call).with(event_payload).and_return(issue)

          post '/v1/events', params: payload

          expected_response = Entities::IssueEntity.new(issue, type: :full).to_json

          expect(response.body).to eq(expected_response)
        end
      end

      context 'when event registration result is invalid' do
        let(:issue) { build(:issue, events_attributes: [action: 'invalid']) }

        it 'is expected to have http status UNPROCESSABLE ENTITY' do
          expect_any_instance_of(EventRegistration).to receive(:call).with(event_payload).and_return(issue)

          post '/v1/events', params: payload

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'is expected to renders unprocessable entity errors messages as JSON' do
          expect_any_instance_of(EventRegistration).to receive(:call).with(event_payload).and_return(issue)

          post '/v1/events', params: payload

          issue.validate

          expect(response.body).to eq({ errors: issue.errors }.to_json)
        end
      end
    end
  end
end

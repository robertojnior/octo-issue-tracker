require 'rails_helper'

RSpec.describe V1::EventsAPI, type: :request do
  describe 'GET /v1/issues/:number/events' do
    let(:issue) { build(:issue, :with_events) }

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

        expected_response = { error: "Couldn't find Issue with number #{issue.number}"}

        expect(response.body).not_to eq(expected_response)
      end
    end
  end
end

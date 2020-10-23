require 'rails_helper'

RSpec.describe EventPayload, type: :value_object do
  let(:payload) {
    {
      'action' => EventAction.list.sample,
      'issue' => {
        'number' => Faker::Number.number,
        'title' => Faker::Lorem.sentence,
        'body' => Faker::Lorem.paragraph,
        'updated_at' => Time.zone.parse('2020-10-23 00:22:00').iso8601
      }
    }
  }

  let(:issue_number) { payload['issue']['number'] }

  subject { described_class.new(payload) }

  describe 'Public methods' do
    describe '#build_issue_params' do
      before do
        allow(Issue).to receive(:find_by).with(number: issue_number).and_return(nil)
      end

      let(:issue_params) {
        {
          number: payload['issue']['number'],
          title: payload['issue']['title'],
          body: payload['issue']['body']
        }
      }

      let(:events_params) {
        {
          events_attributes: [
            {
              action: payload['action'],
              issued_on: payload['issue']['updated_at']
            }
          ]
        }
      }

      context 'when exists an issue with payload number' do
        let(:issue) { instance_double('Issue', persisted?: true) }

        it 'builds without issue params ' do
          allow(Issue).to receive(:find_by).with(number: issue_number).and_return(issue)

          expect(subject.build_issue_params).to eq(events_params)
        end
      end

      context 'when doesnt exists an issue with payload number' do
        it 'builds with issue params' do
          expect(subject.build_issue_params).to eq(issue_params.merge(events_params))
        end
      end
    end
  end

  describe 'Comparable' do
    context 'when two intances have same payload' do
      let(:github_event_payload) { described_class.new(payload) }

      it { is_expected.to eq(github_event_payload) }
    end

    context 'when two intances have different payloads' do
      let(:other_action) { EventAction.list.find { |action| action != payload['action'] } }

      let(:other_payload) { payload.merge('action' => other_action) }

      let(:github_event_payload) { described_class.new(other_payload) }

      it { is_expected.not_to eq(github_event_payload) }
    end
  end
end

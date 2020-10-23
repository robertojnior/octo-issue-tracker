require 'rails_helper'

RSpec.describe EventRegistration, type: :service do
  subject { described_class.new }

  describe 'Public methods' do
    describe '#call' do
      let(:valid_payload) {
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

      let(:number) { valid_payload['issue']['number'] }

      context 'with a valid event payload' do
        let(:event_payload) { EventPayload.new(valid_payload) }

        context 'when issue doesnt exists' do
          before do
            allow(Issue).to receive(:find_by).with(number: number).and_return(nil)
          end

          it 'returns newly created issue' do
            expect(subject.(event_payload)).to eq(Issue.last)
          end

          it 'creates a new issue' do
            expect { subject.(event_payload) }.to change(Issue, :count).by(1)
          end

          it 'creates a new event' do
            expect { subject.(event_payload) }.to change(Event, :count).by(1)
          end
        end

        context 'when issue exists' do
          before do
            allow(event_payload).to receive(:find_or_initialize_issue).and_return(issue)
          end

          let(:issue) { create(:issue) }

          it 'returns issue' do
            expect(subject.(event_payload)).to eq(issue)
          end

          it 'doesnt creates a new issue' do
            expect { subject.(event_payload) }.not_to change(Issue, :count)
          end

          it 'creates a new event' do
            expect { subject.(event_payload) }.to change(Event, :count).by(1)
          end
        end
      end

      context 'with a invalid event payload' do
        let(:invalid_payload) { valid_payload.merge('action' => 'invalid_action') }

        let(:event_payload) { EventPayload.new(invalid_payload) }

        before do
          allow(Issue).to receive(:find_by).with(number: number).and_return(nil)
        end

        it 'returns a invalid issue' do
          expect(subject.(event_payload)).not_to be_valid
        end

        it 'doesnt creates a new issue' do
          expect { subject.(event_payload) }.not_to change(Issue, :count)
        end

        it 'doesnt creates a new event' do
          expect { subject.(event_payload) }.not_to change(Event, :count)
        end
      end
    end
  end
end

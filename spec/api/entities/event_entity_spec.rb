require 'rails_helper'

RSpec.describe Entities::EventEntity, type: :grape_entity do
  let(:event) { build(:event) }

  subject { described_class.new(event).as_json }

  describe 'Exposures' do
    it 'is expected to exposes action and issued on as created at' do
      expect(subject.keys).to eq([:action, :created_at])
    end

    it 'is expected to action equals to event action' do
      expect(subject[:action]).to eq(event.action)
    end

    it 'is expected to created at equals to event issued on in ISO8601 format' do
      expect(subject[:created_at]).to eq(event.issued_on.iso8601)
    end
  end
end

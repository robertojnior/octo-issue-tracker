require 'rails_helper'

RSpec.describe Entities::IssueEntity, type: :grape_entity do
  let(:issue) { build(:issue) }

  subject { described_class.new(issue).as_json }

  describe 'Exposures' do
    it 'is expected to exposes number and title' do
      expect(subject.keys).to eq([:number, :title])
    end

    it 'is expected to number equals to issue number' do
      expect(subject[:number]).to eq(issue.number)
    end

    it 'is expected to title equals to issue title' do
      expect(subject[:title]).to eq(issue.title)
    end
  end
end

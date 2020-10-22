require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:events) }
  end

  describe 'Validations' do
    subject { build(:issue) }

    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_uniqueness_of(:number) }

    it { is_expected.to validate_presence_of(:title) }
  end
end

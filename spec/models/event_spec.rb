require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:issue_id) }

    it { is_expected.to validate_presence_of(:action) }
    it { is_expected.to validate_length_of(:action).is_at_most(12) }
    it { is_expected.to validate_inclusion_of(:action).in_array(EventAction.list) }

    it { is_expected.to validate_presence_of(:issued_on) }
  end
end

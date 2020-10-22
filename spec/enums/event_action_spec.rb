require 'rails_helper'

RSpec.describe EventAction, type: :enumeration do
  subject { EventAction.list }

  let(:associated_values) {
    [
      "opened",
      "edited",
      "deleted",
      "pinned",
      "unpinned",
      "closed",
      "reopened",
      "assigned",
      "unassigned",
      "labeled",
      "unlabeled",
      "locked",
      "unlocked",
      "transferred",
      "milestoned",
      "demilestoned"
    ]
  }

  describe "Associated values" do
    it { is_expected.to contain_exactly(*associated_values) }
  end
end

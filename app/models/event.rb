class Event < ApplicationRecord
  has_enumeration_for :action, with: EventAction, required: true

  validates :issue_id, presence: true

  validates :action, length: { maximum: 12 }

  validates :issued_on, presence: true
end

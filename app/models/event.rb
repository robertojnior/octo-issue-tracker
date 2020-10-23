class Event < ApplicationRecord
  belongs_to :issue

  validates :issue, presence: true

  validates :action, length: { maximum: 12 }

  validates :issued_on, presence: true

  has_enumeration_for :action, with: EventAction, required: true
end

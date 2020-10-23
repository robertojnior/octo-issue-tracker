class Issue < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :number, presence: true
  validates :number, uniqueness: true

  validates :title, presence: true

  accepts_nested_attributes_for :events
end

class Issue < ApplicationRecord
  has_many :events

  validates :number, presence: true
  validates :number, uniqueness: true

  validates :title, presence: true
end

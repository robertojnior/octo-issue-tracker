class Issue < ApplicationRecord
  validates :number, presence: true
  validates :number, uniqueness: true

  validates :title, presence: true
end

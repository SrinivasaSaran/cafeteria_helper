class MenuItem < ApplicationRecord
  belongs_to :menu
  validates :name, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :description, length: { minimum: 3 }
  validates :price, presence: true
end

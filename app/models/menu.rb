class Menu < ApplicationRecord
  has_many :menu_items
  validates :name, length: { in: 2..50 }, uniqueness: { case_sensitive: false }

  def self.active
    where(active_status: true)
  end
end

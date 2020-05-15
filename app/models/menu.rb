class Menu < ApplicationRecord
  has_many :menu_items

  def self.active
    where(active_status: true)
  end
end

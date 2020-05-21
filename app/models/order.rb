class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user

  def self.placed_orders(user_id)
    User.find(user_id).orders.where("placed_at <= ?", DateTime.now)
  end
end

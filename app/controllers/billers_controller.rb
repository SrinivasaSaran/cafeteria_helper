class BillersController < ApplicationController
  before_action :ensure_biller

  def index
    @orders = Order.where("placed_at <= ?", DateTime.now).where(delivered_at: nil)
  end
end

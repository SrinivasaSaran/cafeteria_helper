class BillersController < ApplicationController
  before_action :ensure_biller, only: [:index]
  before_action :ensure_admin, except: [:index]

  def index
    @orders = Order.where("placed_at <= ?", DateTime.now).where(delivered_at: nil)
  end

  def manage_billers
  end
end

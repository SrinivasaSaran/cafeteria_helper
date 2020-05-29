class BillersController < ApplicationController
  before_action :ensure_biller, only: [:index]
  before_action :ensure_admin, except: [:index]

  def index
    @orders = Order.where("placed_at <= ?", DateTime.now).where(delivered_at: nil)
  end

  def manage_billers
    if params[:username]
      @user = User.find_by(name: params[:username])
      if !@user
        flash.now[:alert] = "User not Found! Enter correct name"
      end
    end
  end

  def new
  end
end

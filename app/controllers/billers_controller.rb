class BillersController < ApplicationController
  before_action :ensure_biller, only: [:index]
  before_action :ensure_admin, except: [:index]

  def index
    @orders = Order.where("placed_at <= ?", DateTime.now).where(delivered_at: nil)
  end

  def manage_billers
    @user_id_to_edit = nil
    @user_id_to_edit = params[:user_id_to_edit].to_i if params[:user_id_to_edit]
    if params[:username]
      @user = User.find_by(name: params[:username])
      if !@user
        flash.now[:alert] = "User not Found! Enter correct name"
      end
    end
  end

  def update
    if User.find(params[:id]).role == "customer"
      redirect_to params[:redirect_path]
    else
      user = User.find(params[:id]).
        update(name: params[:name],
               address: params[:address],
               email: params[:email],
               phone_no: params[:phone_no])
      if user
        flash[:notice] = "Update Succesful:)"
        redirect_to params[:redirect_path]
      else
        flash[:invalid] = "Something went Wrong. While Updating Note that no field can be empty. Hover over the fields for more info."
        redirect_to params[:redirect_path]
      end
    end
  end

  def new
  end
end

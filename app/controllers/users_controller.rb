class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :ensure_admin, except: [:create, :new]

  def index
    if params[:username]
      @user = User.find_by(name: params[:username])
      if !@user
        flash.now[:alert] = "User not Found! Enter correct name"
      end
    end
  end

  def create
    if !(params[:password_digest] == params[:password_confirmation_digest])
      redirect_to new_user_path, error: "Password Mismatch.\n You must enter same content in both password fields"
    else
      user = User.create(name: params[:name],
                         role: params[:role],
                         password: params[:password_digest],
                         email: params[:email],
                         password_confirmation: params[:password_confirmation_digest],
                         address: params[:address],
                         phone_no: params[:phone_no])
      if user.valid?
        order = Order.create!(user_id: user.id)
        session[:current_user_id] = user.id
        session[:current_order_id] = order.id
        redirect_to root_path
      else
        flash[:error] = user.errors.full_messages.join(". ")
        redirect_to new_user_path
      end
    end
  end

  def new
  end

  def make_as_biller
    if User.find(params[:user_id]).role == "customer"
      User.find(params[:user_id]).update!(role: "clerk")
    end
    redirect_to params[:redirect_path]
  end
end

class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :ensure_admin, except: [:create, :new]

  def index
    @user_id_to_edit = nil
    @user_id_to_edit = params[:user_id_to_edit].to_i if params[:user_id_to_edit]
    if params[:username]
      @user = User.find_by(name: params[:username])
      if !@user
        flash.now[:alert] = "User not Found! Enter correct name"
      end
    end
  end

  def create
    if !(params[:password_digest] == params[:password_confirmation_digest])
      flash[:error] = "Password Mismatch.\n You must enter same content in both password fields"
      redirect_to new_user_path if params[:role] == "customer"
      redirect_to new_biller_path if params[:role] == "clerk"
    else
      user = User.create(name: params[:name],
                         role: params[:role],
                         password: params[:password_digest],
                         email: params[:email],
                         password_confirmation: params[:password_confirmation_digest],
                         address: params[:address],
                         phone_no: params[:phone_no])
      if user.valid?
        if user.role == "customer"
          order = Order.create!(user_id: user.id)
          session[:current_user_id] = user.id
          session[:current_order_id] = order.id
          redirect_to root_path
        elsif user.role == "clerk"
          redirect_to manage_billers_path
        end
      else
        flash[:error] = user.errors.full_messages.join(". ")
        redirect_to new_user_path if params[:role] == "customer"
        redirect_to new_biller_path if params[:role] == "clerk"
      end
    end
  end

  def new
    if user = current_user
      redirect_to root_path
    end
  end

  def make_as_biller
    user = User.find(params[:user_id])
    if user.role == "customer"
      user.update!(role: "clerk") if user.name != "Walk-in Customer"
    elsif user.role == "clerk"
      user.update!(role: "customer")
    end
    redirect_to params[:redirect_path]
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to params[:redirect_path]
  end
end

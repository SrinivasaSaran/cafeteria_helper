class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
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
        session[:current_user_id] = user.id
        redirect_to menus_path
      else
        flash[:error] = user.errors.full_messages.join(". ")
        redirect_to new_user_path
      end
    end
  end

  def new
  end
end

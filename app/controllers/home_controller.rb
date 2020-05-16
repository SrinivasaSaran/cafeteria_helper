class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if user = current_user
      redirect_to menus_path if user.role == "customer"
      redirect_to "" if user.role == "clerk"
      redirect_to "" if user.role == "admin"
    end
  end

  def authorize
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password_digest])
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      redirect_to root_path, error: "Credentials doesn't Match. Try again!"
    end
  end
end

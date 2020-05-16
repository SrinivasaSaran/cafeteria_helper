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
      order = Order.create!(user_id: user.id)
      session[:current_user_id] = user.id
      session[:current_order_id] = order.id
      redirect_to "/"
    else
      redirect_to root_path, error: "Credentials doesn't Match. Try again!"
    end
  end

  def info
  end

  def destroy
    Order.find(session[:current_order_id]).destroy if Order.find(session[:current_order_id]).order_items.empty?
    reset_session
    @current_user = nil
    redirect_to root_path
  end
end

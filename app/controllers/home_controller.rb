class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in, except: [:destroy]

  def index
    if user = current_user
      redirect_to menus_path if user.role == "customer"
      redirect_to "/billers" if user.role == "clerk"
      redirect_to "/admins" if user.role == "admin"
    end
  end

  def authorize
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password_digest])
      if user.role == "admin" || user.role == "clerk"
        walkin_order = Order.create!(user_id: User.find_by(name: "Walk-in Customer").id)
        session[:walkin_order_id] = walkin_order.id
        order = Order.create!(user_id: user.id)
      else
        order = Order.create!(user_id: user.id)
      end
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
    Order.find(session[:current_order_id]).order_items.destroy_all
    Order.find(session[:current_order_id]).destroy
    if session[:original_order_id]
      Order.find(session[:original_order_id]).order_items.destroy_all
      Order.find(session[:original_order_id]).destroy
    end
    if session[:walkin_order_id]
      Order.find(session[:walkin_order_id]).order_items.destroy_all
      Order.find(session[:walkin_order_id]).destroy
    end
    reset_session
    @current_user = nil
    @original_user = nil
    redirect_to root_path
  end
end

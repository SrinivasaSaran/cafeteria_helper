class AdminsController < ApplicationController
  def index
  end

  def role_change
    session[:original_user_id] = session[:current_user_id]
    session[:current_user_id] = Order.find(session[:current_order_id]).user.id
    redirect_to menus_path
  end

  def role_back
    session[:current_user_id] = session[:original_user_id]
    session[:original_user_id] = nil
    redirect_to root_path
  end
end

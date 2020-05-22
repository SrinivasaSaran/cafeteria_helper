class AdminsController < ApplicationController
  before_action :ensure_admin, except: [:role_change, :role_back]

  def index
  end

  def role_change
    if User.find(session[:current_user_id]).role == "clerk" || User.find(session[:current_user_id]).role == "admin"
      session[:original_user_id] = session[:current_user_id]
      session[:current_user_id] = Order.find(session[:current_order_id]).user.id
      redirect_to menus_path
    end
  end

  def role_back
    if User.find(session[:original_user_id]).role == "clerk" || User.find(session[:original_user_id]).role == "admin"
      session[:current_user_id] = session[:original_user_id]
      session[:original_user_id] = nil
      redirect_to root_path
    end
  end
end

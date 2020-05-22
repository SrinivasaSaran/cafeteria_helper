class AdminsController < ApplicationController
  before_action :ensure_admin, except: [:role_change, :role_back, :mark_as_delivered]

  def index
    @orders = Order.where("placed_at <= ?", DateTime.now).where(delivered_at: nil)
  end

  def role_change
    if User.find(session[:current_user_id]).role == "clerk" || User.find(session[:current_user_id]).role == "admin"
      session[:original_order_id] = session[:current_order_id]
      session[:original_user_id] = session[:current_user_id]
      session[:current_order_id] = session[:walkin_order_id]
      session[:current_user_id] = Order.find(session[:current_order_id]).user.id
      session[:walkin_order_id] = nil
      redirect_to menus_path
    end
  end

  def role_back
    if User.find(session[:original_user_id]).role == "clerk" || User.find(session[:original_user_id]).role == "admin"
      session[:walkin_order_id] = session[:current_order_id]
      session[:current_user_id] = session[:original_user_id]
      session[:current_order_id] = session[:original_order_id]
      session[:original_user_id] = nil
      session[:original_order_id] = nil
      redirect_to root_path
    end
  end

  def mark_as_delivered
    if User.find(session[:current_user_id]).role == "clerk" || User.find(session[:current_user_id]).role == "admin"
      Order.find(params[:order_id]).update!(delivered_at: DateTime.now)
      redirect_to root_path
    end
  end
end

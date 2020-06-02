class AdminsController < ApplicationController
  before_action :ensure_admin, except: [:role_change, :role_back, :mark_as_delivered]

  def index
    @orders = Order.where("placed_at <= ?", DateTime.now).where(delivered_at: nil)
  end

  def manage_menus
    @menu_id_to_edit = params[:menu_id_to_edit].to_i if params[:menu_id_to_edit]
  end

  def stats
    @invoices = Order.where("placed_at >= ? and placed_at <= ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day)
    if params[:from_date].to_s.length > 0 && params[:to_date].to_s.length > 0
      @invoices = Order.where("placed_at >= ? and placed_at <= ?", params[:from_date].to_time.beginning_of_day, params[:to_date].to_time.end_of_day)
      if (params[:username].to_s.strip.length > 0 && params[:username] != "All")
        user_id = User.find_by(name: params[:username]).id
        @invoices = @invoices.where(user_id: user_id)
      end
    end
    @from_date = Date.today
    @to_date = Date.today
    @username = "All"
    @from_date = params[:from_date] if params[:from_date].to_s.length > 0
    @to_date = params[:to_date] if params[:to_date].to_s.length > 0
    @username = params[:username] if (params[:username].to_s.strip.length > 0 && params[:username] != "All")
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

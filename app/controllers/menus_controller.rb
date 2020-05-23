class MenusController < ApplicationController
  before_action :ensure_admin, except: [:index, :show]

  def index
  end

  def show
    @menu = Menu.find(params[:id])
    @order_id = session[:current_order_id]
  end

  def update
    Menu.find(params[:id]).update!(active_status: !Menu.find(params[:id]).active_status)
    redirect_to manage_menus_path
  end
end

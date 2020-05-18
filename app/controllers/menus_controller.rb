class MenusController < ApplicationController
  def index
  end

  def show
    @menu = Menu.find(params[:id])
    @order_id = session[:current_order_id]
  end
end

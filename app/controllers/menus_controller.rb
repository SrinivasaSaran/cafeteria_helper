class MenusController < ApplicationController
  def index
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def cart
    id = session[:current_order_id]
    OrderItem.create!(
      order_id: id,
      menu_item_id: params[:menu_item_id],
      menu_item_name: params[:menu_item_name],
      menu_item_price: params[:menu_item_price],
      quantity: params[:quantity],
      price: params[:quantity].to_f * params[:menu_item_price].to_f,
    )
    redirect_to "/menus/#{session[:current_user_id]}"
  end
end

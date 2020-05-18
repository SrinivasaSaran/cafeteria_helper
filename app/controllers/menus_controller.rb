class MenusController < ApplicationController
  def index
  end

  def show
    @menu = Menu.find(params[:id])
    @order_id = session[:current_order_id]
  end

  def cart
    if item = OrderItem.exist?(session[:current_order_id], params[:menu_item_id])
      updated_quantity = item.quantity + params[:quantity].to_i
      if updated_quantity > 7
        flash[:error] = "You can add only 7 quantity per item..!"
      else
        item.update!(quantity: updated_quantity, price: updated_quantity * params[:menu_item_price].to_f)
      end
    else
      if params[:quantity].to_i > 7
        flash[:error] = "You can add only 7 quantity per item..!"
      else
        OrderItem.create!(
          order_id: session[:current_order_id],
          menu_item_id: params[:menu_item_id],
          menu_item_name: params[:menu_item_name],
          menu_item_price: params[:menu_item_price],
          quantity: params[:quantity],
          price: params[:quantity].to_f * params[:menu_item_price].to_f,
        )
      end
    end
    redirect_to "/menus/#{params[:menu_id]}"
  end
end

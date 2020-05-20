class OrdersController < ApplicationController
  def index
    @pending_orders = User.find(session[:current_user_id]).orders.where("placed_at <= ?", DateTime.now)
  end

  def pending
    @pending_orders = User.find(session[:current_user_id]).orders.where("placed_at <= ?", DateTime.now)
  end

  def create
    User.find(session[:current_user_id]).
      orders.find(session[:current_order_id]).update!(
      total_amount: params[:total_amount],
      placed_at: DateTime.now,
    )
    order = Order.create!(user_id: session[:current_user_id])
    session[:current_order_id] = order.id
    redirect_to pending_orders_path
  end

  def cart
    if item = OrderItem.exist?(session[:current_user_id], session[:current_order_id], params[:menu_item_id])
      updated_quantity = item.quantity + params[:quantity].to_i
      if updated_quantity > 7
        flash[:error] = "You can add only 7 quantities per item..!"
      else
        item.update!(quantity: updated_quantity, price: updated_quantity * params[:menu_item_price].to_f)
      end
    else
      if params[:quantity].to_i > 7
        flash[:error] = "You can add only 7 quantities per item..!"
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

  def remove_from_cart
    User.find(session[:current_user_id]).
      orders.find(session[:current_order_id]).
      order_items.find(params[:order_item_id]).destroy
    redirect_to "/menus/#{params[:menu_id]}"
  end
end

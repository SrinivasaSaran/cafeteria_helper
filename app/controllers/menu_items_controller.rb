class MenuItemsController < ApplicationController
  before_action :ensure_admin

  def create
    item = MenuItem.create(
      name: params[:name],
      description: params[:description],
      menu_id: params[:menu_id],
      price: params[:price],
      active_status: false,
    )
    if item.valid?
      redirect_to edit_menu_path(params[:menu_id])
    else
      redirect_to edit_menu_path(params[:menu_id]), error: item.errors.full_messages.join(". ")
    end
  end

  def update
    Menu.find(params[:menu_id])
        .menu_items.find(params[:id])
        .update!(active_status: !MenuItem.find(params[:id]).active_status)
    redirect_to edit_menu_path(params[:menu_id])
  end

  def destroy
    Menu.find(params[:menu_id]).menu_items.find(params[:id]).destroy
    redirect_to edit_menu_path(params[:menu_id])
  end
end

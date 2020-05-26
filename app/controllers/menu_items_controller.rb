class MenuItemsController < ApplicationController
  before_action :ensure_admin

  def create
    item = MenuItem.create(
      name: params[:name],
      description: params[:description],
      menu_id: params[:menu_id],
      price: params[:price],
    )
    if item.valid?
      redirect_to edit_menu_path(params[:menu_id])
    else
      redirect_to edit_menu_path(params[:menu_id]), error: item.errors.full_messages.join(". ")
    end
  end

  def destroy
    MenuItem.find(params[:id]).destroy
    redirect_to edit_menu_path(params[:menu_id])
  end
end

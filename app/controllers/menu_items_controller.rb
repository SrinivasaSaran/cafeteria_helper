class MenuItemsController < ApplicationController
  before_action :ensure_admin

  def create
    item = MenuItem.create(
      name: params[:name],
      description: params[:description],
      menu_id: params[:menu_id],
      price: params[:price],
      active_status: true,
    )
    if item.valid?
      redirect_to edit_menu_path(params[:menu_id])
    else
      redirect_to edit_menu_path(params[:menu_id]), error: item.errors.full_messages.join(". ")
    end
  end

  def change_status
    Menu.find(params[:menu_id])
        .menu_items.find(params[:id])
        .update!(active_status: !MenuItem.find(params[:id]).active_status)
    redirect_to edit_menu_path(params[:menu_id])
  end

  def update
    item = Menu.find(params[:menu_id]).
      menu_items.find(params[:id]).
      update(name: params[:name], description: params[:description], price: params[:price])
    if item
      flash[:success] = "MenuItem Updated Successfully:)"
      redirect_to edit_menu_path(params[:menu_id])
    else
      flash[:failure] = "Something went Wrong. While Updating MenuItems make sure no field is Blank/Empty. Hover over fields for more Info"
      redirect_to edit_menu_path(params[:menu_id], menuitem_id_to_edit: params[:id])
    end
  end

  def destroy
    Menu.find(params[:menu_id]).menu_items.find(params[:id]).destroy
    redirect_to edit_menu_path(params[:menu_id])
  end
end

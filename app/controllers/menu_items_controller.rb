class MenuItemsController < ApplicationController
  before_action :ensure_admin

  def destroy
    MenuItem.find(params[:id]).destroy
    redirect_to edit_menu_path
  end
end

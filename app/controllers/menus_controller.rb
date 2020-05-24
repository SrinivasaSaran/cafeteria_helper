class MenusController < ApplicationController
  before_action :ensure_admin, except: [:index, :show]

  def index
  end

  def create
    menu = Menu.create(name: params[:menu_name], active_status: false)
    if menu.valid?
      redirect_to manage_menus_path
    else
      redirect_to manage_menus_path, error: menu.errors.full_messages.join(". ")
    end
  end

  def show
    @menu = Menu.find(params[:id])
    @order_id = session[:current_order_id]
  end

  def update
    if Menu.find(params[:id]).menu_items.empty?
      redirect_to manage_menus_path, invalid: "You can't chose an Empty Menu..!  Add Items First"
    else
      Menu.find(params[:id]).update!(active_status: !Menu.find(params[:id]).active_status)
      redirect_to manage_menus_path
    end
  end
end

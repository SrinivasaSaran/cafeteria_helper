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
    @order_id = session_current_order_id
  end

  def edit
    @menu_id_to_edit = params[:menu_id_to_edit].to_i if params[:menu_id_to_edit]
    @menuitem_id_to_edit = params[:menuitem_id_to_edit].to_i if params[:menuitem_id_to_edit]
  end

  def update
    if Menu.find(params[:id]).menu_items.empty?
      redirect_to manage_menus_path, invalid: "You can't chose an Empty Menu..!  Add Items First"
    else
      Menu.find(params[:id]).update!(active_status: !Menu.find(params[:id]).active_status)
      redirect_to manage_menus_path
    end
  end

  def change_name
    menu = Menu.find(params[:menu_id]).update(name: params[:name])
    if menu
      flash[:notice] = "Menu Name Change Succesful:)"
      redirect_to params[:success_route]
    else
      flash[:alert] = "Something went Wrong. Please note that Menu Name can't be Empty. Hover over the field for more Info"
      redirect_to params[:error_route]
    end
  end

  def destroy
    Menu.find(params[:id]).destroy
    redirect_to manage_menus_path
  end
end

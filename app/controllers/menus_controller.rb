class MenusController < ApplicationController
  def index
  end

  def show
    @menu = Menu.find(params[:id])
  end
end

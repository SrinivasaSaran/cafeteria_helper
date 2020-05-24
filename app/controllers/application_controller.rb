class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in
  add_flash_types :error, :invalid

  def ensure_user_logged_in
    original_user
    unless current_user
      redirect_to "/"
    end
  end

  def ensure_admin
    if user = current_user
      unless user.role == "admin"
        redirect_to root_path
      end
    end
  end

  def ensure_biller
    if user = current_user
      unless user.role == "clerk"
        redirect_to root_path
      end
    end
  end

  def current_user
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end

  def original_user
    return @original_user if @original_user
    original_user_id = session[:original_user_id]
    if original_user_id
      @original_user = User.find(original_user_id)
    else
      nil
    end
  end
end

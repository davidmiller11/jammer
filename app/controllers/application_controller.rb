class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  def current_user
    if session[:current_user_id]
      return User.find(session[:current_user_id])
    else
      return nil
    end
  end

  def require_authentication
    if current_user == nil
      redirect_to login_path
    end
  end

end

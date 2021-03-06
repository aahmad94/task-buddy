class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?

  def login(user)
    @current_user = user
    user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def current_user
    return nil unless request.headers["Authorization"]
    @current_user ||= User.find_by(session_token: request.headers["Authorization"])
    return @current_user
  end

end


# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  class_methods do
    def require_login(*args)
      before_action :check_authentication, *args

      helper_method :logged_in?, :current_user
    end
  end

  private

  def check_authentication
    save_location_and_redirect_to(login_path) unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    session[:logged_in_user]
  end

  def current_user=(user)
    session[:logged_in_user] = user.to_param
  end

  def save_location_and_redirect_to(path)
    self.location_before_login = request.path
    redirect_to(path)
  end

  def location_before_login
    session.delete(:location_before_login) || root_path
  end

  def location_before_login=(path)
    session[:location_before_login] = path
  end
end
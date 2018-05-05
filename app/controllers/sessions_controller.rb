# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    self.current_user = UserFromOauth.new(auth_hash).user
    redirect_to location_before_login
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

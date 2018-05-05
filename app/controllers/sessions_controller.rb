# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    self.current_user = UserFromOauth.new(auth_hash).user
    redirect_to location_before_login
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

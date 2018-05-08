# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    self.current_user = UserFromOauth.new(auth_hash).user
    redirect_to location_after_login
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  def oauth
    self.location_after_login = params[:redirect] if params[:redirect]
    redirect_to "/auth/#{params[:provider]}"
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

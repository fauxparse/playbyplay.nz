# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let(:user) { create(:user, :facebook) }

  describe 'GET /login' do
    it 'returns http success' do
      get login_path
      expect(response).to be_successful
    end
  end

  describe 'POST /auth/:provider/callback' do
    it 'redirects to the home page' do
      log_in_as(user)
      expect(response).to redirect_to root_path
    end

    it 'logs the user in' do
      get root_path
      expect { log_in_as(user) }
        .to change { session[:logged_in_user] }
        .from(nil)
        .to(user.id)
    end
  end

  describe 'DELETE /logout' do
    before { log_in_as(user) }

    it 'redirects to the homepage' do
      delete logout_path
      expect(response).to redirect_to root_path
    end

    it 'logs the user out' do
      expect { delete logout_path }
        .to change { session[:logged_in_user] }
        .from(user.id)
        .to(nil)
    end
  end
end

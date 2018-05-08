# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET /reviews' do
    it 'returns http success' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    context 'when not logged in' do
      it 'requires login' do
        get new_review_path
        expect(response).to redirect_to login_path
      end
    end

    context 'when logged in' do
      before { log_in_as(user) }
      let(:user) { create(:user, :facebook) }

      it 'is successful' do
        get new_review_path
        expect(response).to be_successful
      end
    end
  end
end

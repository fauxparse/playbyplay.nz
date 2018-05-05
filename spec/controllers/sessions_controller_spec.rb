# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe 'GET /login' do
    it 'returns http success' do
      get login_path
      expect(response).to be_successful
    end
  end
end

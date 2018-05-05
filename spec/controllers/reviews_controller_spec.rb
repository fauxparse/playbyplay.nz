# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :request do
  describe 'GET /requests' do
    it 'returns http success' do
      get root_path
      expect(response).to be_successful
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :request do
  let(:user) { create(:user, :facebook) }

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

      it 'is successful' do
        get new_review_path
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /' do
    before { log_in_as(user) }

    let(:review_params) do
      {
        production: {
          name: 'Waiting for Godot'
        },
        performance_date: Time.zone.yesterday,
        text: Faker::Hipster.paragraphs(3).join("\n\n")
      }
    end

    def create_review
      post reviews_path, params: { review: review_params }
    end

    it 'is successful' do
      create_review
      expect(response).to be_successful
    end

    it 'creates a review' do
      expect { create_review }.to change { user.reviews.count }.by(1)
    end

    it 'creates a production' do
      expect { create_review }.to change { Production.count }.by(1)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmissionsController, type: :request do
  describe 'GET /submissions' do
    context 'when not logged in' do
      it 'denies access' do
        expect { get submissions_path }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when logged in as a normal user' do
      let(:user) { create(:user, :facebook) }
      before { log_in_as(user) }

      it 'denies access' do
        expect { get submissions_path }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when logged in as a normal user' do
      let(:user) { create(:moderator, :facebook) }
      before { log_in_as(user) }

      it 'allows access' do
        get submissions_path
        expect { get submissions_path }.not_to raise_error
        expect(response).to be_successful
      end
    end
  end
end

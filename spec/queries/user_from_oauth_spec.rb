# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserFromOauth, type: :query do
  subject(:query) { UserFromOauth.new(auth_hash) }
  let(:auth_hash) do
    {
      provider: 'facebook',
      uid: '1234567',
      info: {
        email: 'facebook@example.com',
        name: 'Facebook User'
      }
    }
  end

  describe '#user' do
    subject(:user) { query.user }

    context 'for a new user' do
      it 'creates a new user' do
        expect { user }.to change(User, :count).by 1
      end

      it 'creates a new identity' do
        expect { user }.to change(Identity, :count).by 1
      end

      it 'has an attached identity' do
        expect(user.identities.facebook).to exist
      end
    end

    context 'for an existing user' do
      let!(:identity) do
        create(:identity, auth_hash.slice(:uid, :provider))
      end

      it 'does not create a new user' do
        expect { user }.not_to change(User, :count)
      end

      it 'does not create a new identity' do
        expect { user }.not_to change(Identity, :count)
      end

      it 'has an attached identity' do
        expect(user.identities.facebook.first).to eq identity
      end
    end
  end
end

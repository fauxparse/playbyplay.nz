# frozen_string_literal: true

Before '@facebook' do
  OmniAuth.config.mock_auth[:facebook] = {
    provider: 'facebook',
    uid: '1234567',
    info: {
      email: 'facebook@example.com',
      name: 'Facebook User'
    }
  }
end

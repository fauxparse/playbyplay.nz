# frozen_string_literal: true

module LoginHelper
  def log_in_as(user)
    log_in_with_oauth(user.identities.first)
  end

  private

  def log_in_with_oauth(identity)
    setup_login_mocks(identity)
    post "/auth/#{identity.provider}/callback"
  end

  def setup_login_mocks(identity)
    OmniAuth.config.mock_auth[identity.provider.to_sym] =
      OmniAuth::AuthHash.new(mock_oauth_hash(identity))
    Rails.application.env_config['omniauth.auth'] =
      OmniAuth.config.mock_auth[identity.provider.to_sym]
  end

  def mock_oauth_hash(identity)
    OmniAuth::AuthHash.new(
      'provider' => identity.provider,
      'uid' => identity.uid,
      'info' => {
        'name' => identity.user.name,
        'email' => identity.user.email
      }
    )
  end
end

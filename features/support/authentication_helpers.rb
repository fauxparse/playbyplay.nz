# frozen_string_literal: true

module AuthenticationHelpers
  def log_in_as(user = nil, with: :facebook)
    user ||= create(:user)
    identity = user.identities.find_by(provider: with) ||
      create(:identity, user: user, provider: with)
    mock_oauth(identity)
    visit(login_path)
    click_link('Facebook')
  end

  private

  def mock_oauth(identity)
    OmniAuth.config.mock_auth[identity.provider.to_sym] = {
      provider: identity.provider,
      uid: identity.uid,
      info: {
        name: identity.user.name,
        email: identity.user.email
      }
    }
  end
end

World(AuthenticationHelpers)

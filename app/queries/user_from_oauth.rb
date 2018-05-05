# frozen_string_literal: true

class UserFromOauth
  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def user
    @user ||= Identity.find_or_create_by(provider: provider, uid: uid)
  end

  private

  attr_reader :auth_hash

  def provider
    auth_hash[:provider]
  end

  def uid
    auth_hash[:uid]
  end
end

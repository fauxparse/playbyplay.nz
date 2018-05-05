# frozen_string_literal: true

class UserFromOauth
  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def user
    @user ||= identity.user
  end

  private

  attr_reader :auth_hash

  def identity
    Identity.find_by(provider: provider, uid: uid) || new_user.identities.first
  end

  def new_user
    User.create!(
      name: info_hash[:name],
      email: info_hash[:email],
      identities: [Identity.new(provider: provider, uid: uid)]
    )
  end

  def info_hash
    auth_hash[:info]
  end

  def provider
    auth_hash[:provider]
  end

  def uid
    auth_hash[:uid]
  end
end

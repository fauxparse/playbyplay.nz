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
    Identity.find_by(provider: provider, uid: uid) || new_identity
  end

  def authenticated_user
    User.find_by(email: email) ||
      User.create!(name: name, email: email)
  end

  def new_identity
    authenticated_user.identities.create!(provider: provider, uid: uid)
  end

  def info_hash
    auth_hash[:info]
  end

  def name
    info_hash[:name]
  end

  def email
    info_hash[:email]
  end

  def provider
    auth_hash[:provider]
  end

  def uid
    auth_hash[:uid]
  end
end

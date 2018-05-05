# frozen_string_literal: true

class UserFromOauth
  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def user
    auth_hash[:uid]
  end

  private

  attr_reader :auth_hash
end

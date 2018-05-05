# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :user

  validates :provider, :uid, presence: true
  validates :provider, uniqueness: { scope: :user_id }
  validates :uid, uniqueness: { scope: :provider }

  enum provider:
    OmniAuth.registered_providers.map { |p| [p, p.to_s] }.to_h.freeze
end

# frozen_string_literal: true

class Identity < ApplicationRecord
  validates :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  enum provider:
    OmniAuth.registered_providers.map { |p| [p, p.to_s] }.to_h.freeze
end

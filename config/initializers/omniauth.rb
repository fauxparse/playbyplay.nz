# frozen_string_literal: true

module OmniAuth
  def self.registered_providers
    @registered_providers ||= []
  end

  class Builder
    def provider_with_memoization(name, *args, &block)
      options = args.extract_options!
      OmniAuth.registered_providers << (options[:name] || name)
      provider_without_memoization(name, *args, options, &block)
    end

    alias provider_without_memoization provider
    alias provider provider_with_memoization
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.credentials.facebook[:id],
    Rails.application.credentials.facebook[:secret],
    secure_image_url: true

  provider :twitter,
    Rails.application.credentials.twitter[:id],
    Rails.application.credentials.twitter[:secret]

  provider :google_oauth2,
    Rails.application.credentials.google[:id],
    Rails.application.credentials.google[:secret],
    image_aspect_ratio: 'square',
    name: :google
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.test_mode = Rails.env.test?

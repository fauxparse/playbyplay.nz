# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.credentials.facebook[:id],
    Rails.application.credentials.facebook[:secret],
    secure_image_url: true
end

OmniAuth.config.logger = Rails.logger

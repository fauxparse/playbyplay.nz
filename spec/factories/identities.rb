# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    user
    provider 'facebook'
    uid Faker::Crypto.md5
  end
end

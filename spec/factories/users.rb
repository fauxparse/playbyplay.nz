# frozen_string_literal: true

FactoryBot.define do
  sequence(:name) { |n| "User #{n}" }

  factory :user do
    name
    email { Faker::Internet.safe_email(name) }

    factory :reviewer

    trait :facebook do
      after :build do |user|
        user.identities.build(provider: 'facebook', uid: Faker::Crypto.md5)
      end
    end
  end
end

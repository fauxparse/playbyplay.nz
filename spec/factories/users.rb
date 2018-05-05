# frozen_string_literal: true

FactoryBot.define do
  sequence(:name) { |n| "User #{n}" }
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    name
    email
  end
end

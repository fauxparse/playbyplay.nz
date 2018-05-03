# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    text { Faker::Hipster.paragraphs(3).join("\n\n") }
  end
end

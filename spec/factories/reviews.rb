# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    text { Faker::Hipster.paragraphs(3).join("\n\n") }

    trait :with_multiple_versions do
      text 'First version'

      after :create do |review|
        review.update!(text: 'Second version')
        review.update!(text: 'Third version')
        review.update!(text: 'Fourth version')
      end
    end
  end
end

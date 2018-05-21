# frozen_string_literal: true

FactoryBot.define do
  factory :submission do
    review

    trait :rejected do
      state 'rejected'
      feedback 'It just wasn’t that great'
    end
  end
end

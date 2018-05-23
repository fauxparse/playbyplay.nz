# frozen_string_literal: true

FactoryBot.define do
  factory :submission do
    review

    trait :rejected do
      state 'rejected'
      feedback 'It just wasn’t that great'
    end

    after :create do |submission|
      submission.review.submitted! if submission.review.draft?
    end
  end
end

# frozen_string_literal: true

class SubmitReview
  attr_reader :review

  def initialize(review)
    @review = review
  end

  def call
    review.submissions.create!
    review.submitted!
  end
end

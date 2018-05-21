# frozen_string_literal: true

class ApproveSubmission
  attr_reader :submission, :moderator

  def initialize(submission, moderator)
    @submission = submission
    @moderator = moderator
  end

  def call
    submission.transaction do
      submission.update!(moderator: moderator)
      submission.approved!
      review.published!
    end
  end

  private

  def review
    submission.review
  end
end

# frozen_string_literal: true

class ModerateSubmission
  include Cry

  attr_reader :submission, :moderator, :params

  def initialize(submission, moderator, params)
    @submission = submission
    @moderator = moderator
    @params = params.permit(:state, :feedback)
  end

  def call
    Submission.transaction do
      submission.update!(attributes)
      review.published! if submission.approved?
      publish(:success)
    end
  rescue ActiveRecord::RecordInvalid
    moderation_failed
  end

  private

  def attributes
    @params.to_h.merge(moderator: moderator)
  end

  def review
    submission.review
  end

  def moderation_failed
    submission.state = submission.state_was
    publish(:failure)
  end
end

# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def index
    authorize! :read, Submission
  end

  def show
    authorize! :read, submission
  end

  def moderate
    authorize! :update, submission
    ModerateSubmission
      .new(submission, current_user, moderation_params)
      .on(:success) { moderation_success }
      .on(:failure) { moderation_failure }
      .call
  end

  private

  def moderation_params
    params.require(:submission)
  end

  def moderation_success
    submission.reload
    redirect_to submissions_path, alert: t(".#{submission.state}")
  end

  def moderation_failure
    render :show
  end

  def submissions
    @submissions ||= Submissions.new(params)
  end

  def submission
    @submission ||= Submission.find(params[:id])
  end

  helper_method :submission, :submissions
end

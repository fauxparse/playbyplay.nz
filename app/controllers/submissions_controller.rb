# frozen_string_literal: true

class SubmissionsController < ApplicationController
  require_login

  def index
    authorize! :read, Submission
  end

  def show
    authorize! :read, submission
  end

  def update
    authorize! :update, submission
    update_review
    redirect_to submission
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
    return {} unless params[:submission].present?
    @moderation_params ||= params.require(:submission)
  end

  def review_params
    @review_params ||= moderation_params[:review] || {}
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

  def review_form
    @review_form ||= ReviewForm.new(submission.review, review_params)
  end

  def update_review
    review_form.update(review_params) if review_params.present?
  end

  helper_method :submission, :submissions, :review_form
end

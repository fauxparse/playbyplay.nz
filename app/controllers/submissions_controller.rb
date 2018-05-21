# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def index
    authorize! :read, Submission
  end

  def show
    authorize! :read, submission
  end

  def approve
    authorize! :update, submission
    ApproveSubmission.new(submission, current_user).call
    redirect_to submissions_path, alert: t('.approved')
  end

  private

  def submissions
    @submissions ||= Submissions.new(params)
  end

  def submission
    @submission ||= Submission.find(params[:id])
  end

  helper_method :submission, :submissions
end

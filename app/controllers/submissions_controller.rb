# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def index
    authorize! :read, Submission
  end

  private

  def submissions
    @submissions ||=
      Submissions.new(params)
  end

  helper_method :submissions
end

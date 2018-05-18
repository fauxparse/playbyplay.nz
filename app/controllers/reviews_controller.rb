# frozen_string_literal: true

class ReviewsController < ApplicationController
  require_login only: %i[new]

  def new
    @review = current_user.reviews.build(
      production: Production.new,
      performance_date: Time.zone.today
    )
  end

  def create
    render :new unless review_form.update(params[:review])
  end

  def submit
    redirect_to root_path
  end

  private

  def review
    @review ||= current_user.reviews.build
  end

  def review_form
    @review_form ||= ReviewForm.new(review, params[:review])
  end

  helper_method :review, :review_form
end

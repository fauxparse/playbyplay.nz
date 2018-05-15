# frozen_string_literal: true

class ReviewsController < ApplicationController
  require_login only: %i[new]

  def new
    @review = current_user.reviews.build(production: Production.new, performance_date: Time.zone.today)
  end

  private

  def review
    @review
  end

  def review_form
    @review_form ||= ReviewForm.new(review)
  end

  helper_method :review_form
end

# frozen_string_literal: true

class ReviewsController < ApplicationController
  require_login only: %i[new]
end

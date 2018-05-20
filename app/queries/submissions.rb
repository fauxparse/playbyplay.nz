# frozen_string_literal: true

class Submissions < ApplicationQuery
  class Parameters < QueryParameters
    property :state
  end

  private

  def default_scope
    super.includes(review: %i[reviewer production])
  end
end

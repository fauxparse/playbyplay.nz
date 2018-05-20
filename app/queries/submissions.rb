# frozen_string_literal: true

class Submissions
  include QueryOptions

  query_option :state

  def initialize(options = {})
    self.options = options
  end

  private

  def scope
    super.includes(review: %i[reviewer production])
  end

  def scope_state(scope)
    scope.where(state: state)
  end
end

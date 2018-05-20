# frozen_string_literal: true

class Productions
  include QueryOptions

  query_options :query, :limit

  def initialize(options = {})
    self.options = options
  end

  private

  def scope_query(scope)
    scope.where(table[:name].lower.matches("%#{query}%"))
  end

  def scope_limit(scope)
    scope.limit(limit)
  end

  def table
    Production.arel_table
  end
end

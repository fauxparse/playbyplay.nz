# frozen_string_literal: true

class Productions < ApplicationQuery
  class Parameters < QueryParameters
    property :query
    property :limit
  end

  private

  def query(scope, query)
    scope.where(table[:name].lower.matches("%#{query}%"))
  end

  def limit(scope, limit)
    scope.limit(limit)
  end

  def table
    Production.arel_table
  end
end

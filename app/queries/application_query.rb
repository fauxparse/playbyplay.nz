# frozen_string_literal: true

class ApplicationQuery
  include Enumerable

  attr_reader :parameters

  def initialize(parameters = {})
    @parameters = self.class.const_get(:Parameters).new(parameters)
  end

  def each
    return enum_for(:each) unless block_given?
    scope.in_batches.each_record do |result|
      yield result
    end
  end

  private

  def default_scope
    self.class.name.singularize.constantize
  end

  def scope
    parameters.inject(default_scope) do |scope, (parameter, value)|
      value.present? ? refine_scope(scope, parameter, value) : scope
    end
  end

  def refine_scope(scope, parameter, value)
    if respond_to?(parameter, true)
      send(parameter, scope, value)
    else
      scope.where(parameter => value)
    end
  end
end
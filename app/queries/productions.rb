# frozen_string_literal: true

class Productions
  include Enumerable

  OPTIONS = %i[query limit].freeze
  OPTIONS.each { |option| attr_reader(option) }

  def initialize(options = {})
    self.options = options.to_h.symbolize_keys
  end

  def options
    OPTIONS.inject({}) do |result, key|
      result.merge(key => send(key))
    end
  end

  def each
    return enum_for(:each) unless block_given?

    productions.in_batches.each_record do |production|
      yield production
    end
  end

  private

  def scope
    @scope || Production
  end

  def options=(options)
    options.assert_valid_keys(:scope, *OPTIONS).each do |option, value|
      instance_variable_set(:"@#{option}", value)
    end
  end

  def productions
    @productions ||=
      options.inject(scope) do |scope, (key, value)|
        value.present? ? send(:"scope_#{key}", scope) : scope
      end
  end

  def scope_query(scope)
    scope.where(Production.arel_table[:name].lower.matches("%#{query}%"))
  end

  def scope_limit(scope)
    scope.limit(limit)
  end
end

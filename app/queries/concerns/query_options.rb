# frozen_string_literal: true

module QueryOptions
  extend ActiveSupport::Concern

  included do
    include Enumerable
  end

  class_methods do
    def options
      @options ||= []
    end

    def query_option(name)
      options << name unless options.include?(name)
      attr_accessor name
    end

    def query_options(*names)
      names.each { |name| query_option(name) }
    end
  end

  def options
    self.class.options.inject({}) do |result, key|
      result.merge(key => send(key))
    end
  end

  def options=(options)
    sanitize_options(options).each do |option, value|
      send(:"#{option}=", value)
    end
  end

  def each
    return enum_for(:each) unless block_given?

    results.in_batches.each_record do |result|
      yield result
    end
  end

  private

  def sanitize_options(options)
    options.to_h.symbolize_keys.assert_valid_keys(:scope, *self.class.options)
  end

  def scope
    @scope || self.class.name.singularize.constantize
  end

  def results
    @results ||=
      options.inject(scope) do |scope, (key, value)|
        value.present? ? send(:"scope_#{key}", scope) : scope
      end
  end
end

module Sluggable
  extend ActiveSupport::Concern

  included do
    acts_as_url :name, sluggable_options

    validates :name, presence: true

    alias_method :to_param, :slug
  end

  module ClassMethods
    def random_deduplicator
      Enumerator.new { |enum| loop { enum.yield rand(10_000..99_999) } }
    end

    def sluggable_options
      {
        url_attribute: :slug,
        limit: 32,
        only_when_blank: true,
        duplicate_sequence: random_deduplicator
      }
    end
  end
end

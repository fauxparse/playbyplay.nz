# frozen_string_literal: true

module Versionable
  extend ActiveSupport::Concern

  included do
    has_many :versions,
      -> { oldest_first },
      as: :versionable,
      dependent: :destroy

    after_update :create_version, if: :versioned_attributes_changed?
  end

  class_methods do
    def versioned_attributes
      @versioned_attributes ||= []
    end

    def track_changes_to(*attributes)
      versioned_attributes.concat(attributes)
    end
  end

  def version_number
    @version_number || versions_count + 1
  end

  def at(version)
    [version, *version.lower_items].reverse.inject(self) do |state, older|
      older.unpatch(state)
    end
  end

  def versioned_attributes
    self.class.versioned_attributes
  end

  def compare_with(other)
    versioned_attributes.inject({}) do |changes, attr|
      first = send(attr)
      second = other.send(attr)
      changes[attr] = [first, second] unless first == second
      changes
    end
  end

  attr_writer :version_number

  private

  def create_version
    versions.create!(
      changes: saved_changes.slice(*versioned_attributes),
      created_at: attribute_before_last_save(:updated_at)
    )
  end

  def versioned_attributes_changed?
    versioned_attributes.any? { |attr| saved_change_to_attribute?(attr) }
  end
end

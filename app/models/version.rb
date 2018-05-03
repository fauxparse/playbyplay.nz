# frozen_string_literal: true

require 'diff/lcs/string'

class Version < ApplicationRecord
  belongs_to :versionable, polymorphic: true, counter_cache: true
  acts_as_list column: :number, scope: %i[versionable_type versionable_id]

  serialize :diff, DiffSerializer

  scope :oldest_first, -> { order(:number) }

  def changes=(changes)
    self.diff = changes.transform_values { |old, new| old.to_s.diff(new.to_s) }
  end

  def unpatch(versionable)
    versionable.dup.tap do |previous|
      diff.each do |attr, patch|
        previous.send(:"#{attr}=", versionable.send(attr).unpatch!(patch))
      end
      previous.version_number = number
      previous.updated_at = created_at
      previous.freeze
    end
  end
end

# frozen_string_literal: true

class Review < ApplicationRecord
  include Versionable

  track_changes_to :text

  validates :text, presence: true
end

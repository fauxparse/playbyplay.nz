# frozen_string_literal: true

class Review < ApplicationRecord
  include Versionable

  belongs_to :reviewer, class_name: 'User'
  belongs_to :production, autosave: true

  track_changes_to :text

  validates :text, :performance_date, presence: true
end

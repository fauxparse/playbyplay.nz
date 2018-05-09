# frozen_string_literal: true

class Review < ApplicationRecord
  include Versionable

  belongs_to :production

  track_changes_to :text

  validates :text, :performance_date, presence: true
end

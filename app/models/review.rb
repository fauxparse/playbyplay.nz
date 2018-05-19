# frozen_string_literal: true

class Review < ApplicationRecord
  include Versionable
  include Hashable

  belongs_to :reviewer, class_name: 'User'
  belongs_to :production, autosave: true
  has_many :submissions, dependent: :destroy

  enum state: {
    draft: 'draft',
    submitted: 'submitted',
    published: 'published',
    rejected: 'rejected'
  }

  track_changes_to :text

  validates :text, :performance_date, presence: true
end

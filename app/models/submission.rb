# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :review
  belongs_to :moderator, class_name: 'User', optional: true

  enum state: {
    pending: 'pending',
    approved: 'approved',
    changes_requested: 'changes_requested',
    rejected: 'rejected'
  }

  validates :review, :version_number, presence: true

  def version_number
    super || (self.version_number = review.version_number)
  end
end

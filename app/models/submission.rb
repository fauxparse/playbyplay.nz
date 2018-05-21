# frozen_string_literal: true

class Submission < ApplicationRecord
  include Hashable

  belongs_to :review
  belongs_to :moderator, class_name: 'User', optional: true
  has_one :reviewer, through: :review
  has_one :production, through: :review

  enum state: {
    pending: 'pending',
    changes_requested: 'changes_requested',
    approved: 'approved',
    rejected: 'rejected'
  }

  validates :review, :version_number, presence: true
  validates :feedback, presence: true, unless: :pending?

  def version_number
    super || (self.version_number = review.version_number)
  end
end

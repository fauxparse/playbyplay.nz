# frozen_string_literal: true

class User < ApplicationRecord
  has_many :identities, dependent: :destroy, autosave: true
  has_many :reviews, foreign_key: :reviewer_id, dependent: :destroy

  validates :name, presence: true

  def to_s
    name
  end
end

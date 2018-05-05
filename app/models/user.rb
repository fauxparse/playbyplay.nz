# frozen_string_literal: true

class User < ApplicationRecord
  has_many :identities, dependent: :destroy, autosave: true

  validates :name, presence: true

  def to_s
    name
  end
end

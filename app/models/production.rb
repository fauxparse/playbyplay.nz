# frozen_string_literal: true

class Production < ApplicationRecord
  include Sluggable

  has_many :reviews, dependent: :destroy

  scope :newest_first, -> { order(created_at: :desc) }
end

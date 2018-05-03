# frozen_string_literal: true

class Review < ApplicationRecord
  validates :text, presence: true
end

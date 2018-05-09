# frozen_string_literal: true

class Production < ApplicationRecord
  include Sluggable

  has_many :reviews, dependent: :destroy
end

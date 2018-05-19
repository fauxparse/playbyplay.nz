# frozen_string_literal: true

class AddPerformanceDateToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :performance_date, :date
  end
end

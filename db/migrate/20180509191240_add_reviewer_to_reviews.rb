# frozen_string_literal: true

class AddReviewerToReviews < ActiveRecord::Migration[5.2]
  def change
    change_table :reviews do |t|
      t.belongs_to :reviewer,
        foreign_key: { to_table: :users, on_delete: :cascade }
    end
  end
end

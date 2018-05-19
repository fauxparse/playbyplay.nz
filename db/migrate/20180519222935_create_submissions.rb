# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.belongs_to :review, foreign_key: { on_delete: :cascade }
      t.belongs_to :moderator,
        required: false,
        foreign_key: { to_table: :users, on_delete: :nullify }
      t.integer :version_number
      t.string :state, limit: 32, default: 'pending', index: true
      t.text :feedback

      t.timestamps
    end

    change_table :reviews do |t|
      t.string :state, limit: 32, default: 'draft', index: true
    end
  end
end

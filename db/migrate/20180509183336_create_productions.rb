# frozen_string_literal: true

class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.string :name, required: true, index: true
      t.string :slug, required: true
      t.timestamp :created_at

      t.index :slug, unique: true
    end

    change_table :reviews do |t|
      t.belongs_to :production, foreign_key: { on_delete: :restrict }
    end
  end
end

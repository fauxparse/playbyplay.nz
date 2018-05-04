# frozen_string_literal: true

class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.belongs_to :versionable, polymorphic: true, index: true
      t.text :diff, required: true
      t.integer :number, required: true
      t.timestamp :created_at
    end

    change_table :reviews do |t|
      t.integer :versions_count, default: 0
    end
  end
end

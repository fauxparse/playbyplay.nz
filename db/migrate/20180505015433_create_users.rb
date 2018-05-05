# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end

    change_table :identities do |t|
      t.belongs_to :user, foreign_key: { on_delete: :cascade }
      t.index %i[user_id provider], unique: true
    end
  end
end

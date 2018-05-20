# frozen_string_literal: true

class AddModeratorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :moderator, :boolean, index: true, default: false
  end
end

# frozen_string_literal: true

class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.string :provider, required: true
      t.string :uid, required: true
      t.timestamp :created_at

      t.index %i[provider uid], unique: true
    end
  end
end

# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.text :url, null: false
      t.string :slug, null: false, index: { unique: true }

      t.timestamps
    end
  end
end

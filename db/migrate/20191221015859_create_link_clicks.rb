# frozen_string_literal: true

class CreateLinkClicks < ActiveRecord::Migration[6.0]
  def change
    create_table :link_clicks do |t|
      t.belongs_to :link, null: false, foreign_key: true
      t.string :host, null: false
      t.text :user_agent, null: false
      t.text :referer
      t.string :anonymized_ip, null: false

      t.timestamps
    end
  end
end

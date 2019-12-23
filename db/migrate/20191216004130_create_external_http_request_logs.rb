# frozen_string_literal: true

class CreateExternalHttpRequestLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :external_http_request_logs do |t|
      t.text :kind, null: false
      t.jsonb :meta
      t.text :response_body, null: false
      t.integer :response_code, null: false

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddStatusToLink < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :status, :integer, default: 0
  end
end

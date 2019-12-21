class AddUserAgentColumnsToLinkClick < ActiveRecord::Migration[6.0]
  def change
    add_column :link_clicks, :device_family, :string
    add_column :link_clicks, :device_model, :string
    add_column :link_clicks, :device_brand, :string
    add_column :link_clicks, :os_family, :string
    add_column :link_clicks, :os_version, :string
    add_column :link_clicks, :user_agent_family, :string
    add_column :link_clicks, :user_agent_version, :string
  end
end

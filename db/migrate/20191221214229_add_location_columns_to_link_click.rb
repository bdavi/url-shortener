class AddLocationColumnsToLinkClick < ActiveRecord::Migration[6.0]
  def change
    add_column :link_clicks, :country, :string
    add_column :link_clicks, :region, :string
    add_column :link_clicks, :city, :string
    add_column :link_clicks, :isp, :string
    add_column :link_clicks, :latitude, :decimal
    add_column :link_clicks, :longitude, :decimal
    add_column :link_clicks, :timezone, :string
    add_column :link_clicks, :timezone_name, :string
  end
end

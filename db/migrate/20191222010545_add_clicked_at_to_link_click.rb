class AddClickedAtToLinkClick < ActiveRecord::Migration[6.0]
  def up
    add_column :link_clicks, :clicked_at, :datetime

    sql = <<-SQL
      UPDATE
        link_clicks
      SET
        clicked_at = created_at
    SQL
    ActiveRecord::Base.connection.execute(sql)

    change_column :link_clicks, :clicked_at, :datetime, null: false
  end

  def down
    remove_column :link_clicks, :clicked_at
  end
end

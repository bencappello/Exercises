class RenameColumnShortUrlInVisits < ActiveRecord::Migration
  def change
    rename_column :visits, :short_url, :short_url_id
  end
end

class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id, presence: true
      t.integer :short_url, presence: true

      t.timestamps
    end
    add_index :visits, :visitor_id
    add_index :visits, :short_url
  end
end

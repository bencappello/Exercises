class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question, presence: true
      t.timestamps
    end
  end
end

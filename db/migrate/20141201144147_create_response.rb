class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :answer_choice_id, presence: true
      t.integer :author_id, presence: true
      t.timestamps
    end
    add_index :responses, :answer_choice_id
    add_index :responses, :author_id
  end
end

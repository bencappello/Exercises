class CreateAnswerChoice < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :answer_choice, presence: true, unique: true
      t.integer :question_id, presence:true
      t.timestamps
    end
    add_index :answer_choices, :question_id
  end
end

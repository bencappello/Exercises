class ChangePollValidations < ActiveRecord::Migration
  def change
    change_column :polls, :author_id, :integer, unique: false, null: false
    change_column :polls, :title, :string, null: false
    change_column :users, :user_name, :string, null: false
    change_column :questions, :question, :text, null: false
    add_column :questions, :poll_id, :integer, null: false, default: 0
    change_column :answer_choices, :answer_choice, :text, null: false
    change_column :answer_choices, :question_id, :integer, null: false
    change_column :responses, :answer_choice_id, :integer, null: false
    change_column :responses, :author_id, :integer, null: false

  end
end

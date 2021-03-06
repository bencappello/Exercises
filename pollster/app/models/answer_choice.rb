require 'files.rb'

class AnswerChoice < ActiveRecord::Base
  validates :question_id, presence: true
  validates :answer_choice, uniqueness: true, presence: true

  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )
end

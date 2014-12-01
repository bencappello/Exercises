require 'files.rb'

class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :author_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author_of_poll
  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
    )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question


  def sibling_responses
    self.question.responses.where("? IS NULL OR responses.id != ?", self.id, self.id)
  end

  private

  def respondent_is_not_author_of_poll
    if self.author_id == self.question.poll.author_id
      errors[:base] << "respondent is the author of this... cheater"
    end
  end

  def respondent_has_not_already_answered_question

    #previous_respondents = self.sibling_responses.map(&:respondent)
    if self.sibling_responses.exists?(["responses.author_id = ?", self.author_id])
      errors[:base] << "respondent has already answered question"
    end
  end
end

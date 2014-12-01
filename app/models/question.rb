require 'files.rb'

class Question < ActiveRecord::Base
  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  def results
    something = self.answer_choices.includes(:responses)
    result = Hash.new { |h, k| h[k] = 0 }
    something.each do |answer|
      result[answer.answer_choice] = answer.responses.length
    end
    result
  end

  def results_s
     AnswerChoice.find_by_sql([<<-SQL, self.id])
      SELECT
        answer_choices.*,
        COUNT(responses.id) AS response_count
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses
        ON responses.answer_choice_id = answer_choices.id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
      SQL
  end

  def results_ar
    result = self.answer_choices
    .select("answer_choices.*, COUNT(responses.id) AS response_count")
    .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
    .group("answer_choices.id")

    counts = Hash.new { |h, k| h[k] = 0 }
    result.each do |result|
      counts[result.answer_choice] = result.response_count
    end
    counts
  end

end

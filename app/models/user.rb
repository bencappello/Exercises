require 'files.rb'

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :author_id,
    primary_key: :id
  )

  def completed_polls
    # Poll.find_by_sql([<<-SQL, self.id])
    # SELECT
    #   polls.*,
    #   COUNT(DISTINCT questions.id) AS question_count
    # FROM
    #   polls
    # JOIN
    #   questions ON questions.poll_id = polls.id
    # JOIN
    #   answer_choices ON answer_choices.question_id = questions.id
    # LEFT OUTER JOIN
    #   (
    #   SELECT
    #     responses.*
    #   FROM
    #     responses
    #   WHERE
    #     responses.author_id = ?
    #   )
    #   AS user_responses ON user_responses.answer_choice_id = answer_choices.id
    # GROUP BY
    #   polls.id
    # HAVING
    #   COUNT(DISTINCT questions.id) = COUNT(user_responses.id)
    # SQL

    user_responses = <<-SQL
      LEFT OUTER JOIN
      (
        SELECT
          responses.*
        FROM
          responses
        WHERE
          responses.author_id = #{self.id}
      )
      AS user_responses ON user_responses.answer_choice_id = answer_choices.id
    SQL

    completed_ps = Poll.joins("JOIN questions ON questions.poll_id = polls.id")
    .joins("JOIN answer_choices ON answer_choices.question_id = questions.id")
    .joins(user_responses)
    .group("polls.id")
    .having("COUNT(DISTINCT questions.id) = COUNT(user_responses.id)")
  end

  def uncompleted_polls
    user_responses = <<-SQL
    LEFT OUTER JOIN
    (
      SELECT
      responses.*
      FROM
      responses
      WHERE
      responses.author_id = #{self.id}
    )
    AS user_responses ON user_responses.answer_choice_id = answer_choices.id
    SQL

    uncompleted_ps = Poll.joins("JOIN questions ON questions.poll_id = polls.id")
    .joins("JOIN answer_choices ON answer_choices.question_id = questions.id")
    .joins(user_responses)
    .group("polls.id")
    .having("COUNT(DISTINCT questions.id) != COUNT(user_responses.id)")
  end
end

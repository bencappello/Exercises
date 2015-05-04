require_relative 'files'

class QuestionFollowerLink
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_followers')
    results.map { |result| QuestionFollowerLink.new(result) }
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise 'already saved!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, user_id, question_id)
    INSERT INTO
    question_followers (user_id, question_id)
    VALUES
    (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      users
    JOIN
      question_followers ON users.id = question_followers.user_id
    JOIN
      questions ON questions.id = question_followers.question_id
    WHERE
      question_followers.question_id = ?
  SQL

    results.map { |result| User.new(result)}
  end

  def self.followed_quetions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      questions
    JOIN
      question_followers ON questions.id = question_followers.question_id
    JOIN
      users ON users.id = question_followers.user_id
    WHERE
      question_followers.user_id = ?
  SQL

    results.map { |result| Question.new(result)}
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
    (
      SELECT
        questions.id, COUNT(*) followers
      FROM
        questions
      JOIN
        question_followers ON questions.id = question_followers.question_id
      GROUP BY
        questions.id
    ) AS ques_and_foll
    JOIN
      questions ON questions.id = ques_and_foll.id
    -- JOIN
    --   question_followers ON questions.id = question_followers.question_id
    -- WHERE
    --   questions.id =
    ORDER BY ques_and_foll.followers DESC
    LIMIT ?;
  SQL

    results.map { |result| Question.new(result) }
  end

end

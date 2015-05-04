require_relative 'files'

class QuestionLikeLink
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    results.map { |result| QuestionLikeLink.new(result) }
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
    question_likes (user_id,question_id)
    VALUES
    (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      users
    JOIN
      question_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*) like_count
    FROM
      users
    JOIN
      question_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL

    results.first['like_count']
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes ON questions.id = question_likes.question_id
    WHERE
      question_likes.user_id = ?
  SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        (
          SELECT
          questions.id, COUNT(*) like_count
          FROM
            questions
          JOIN
            question_likes ON question_likes.question_id = questions.id
          GROUP BY
            question_likes.question_id
          ORDER BY
            like_count DESC
        ) AS num_likes
      JOIN
        questions ON questions.id = num_likes.id
      LIMIT
        ?

    SQL
      results.map { |result| Question.new(result) }
  end


end

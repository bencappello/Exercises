require_relative 'files'

class User
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map { |result| User.new(result) }
  end

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id = options['id'] #maybe should initialize as null
    @fname = options['fname']
    @lname = options['lname']
  end

  def create
    raise 'already saved!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    INSERT INTO
    users (fname, lname)
    VALUES
    (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
    *
    FROM
    users
    WHERE
    id = ?
    SQL

    results.map! { |result| User.new(result) }
    results.first
  end

  def self.find_by_name(fname,lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
    *
    FROM
    users
    WHERE
    fname = ? AND lname = ?
    SQL

    results.map! { |result| User.new(result) }
    results.first
  end

  def authored_questions
    Question.find_by_author(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollowerLink.followed_quetions_for_user_id(@id)
  end

  def liked_questions
    QuestionLikeLink.liked_questions_for_user_id(@id)
  end

  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      CAST(nums.like_num AS FLOAT)/nums.question_num
    FROM
      (
        SELECT
        questions.author_id, COUNT(question_likes.question_id) like_num, COUNT(DISTINCT(questions.id)) question_num
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = 1
      ) nums
    SQL
  end

  def save
    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        "#{self.class}s"
      VALUES
        (?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, self.instance_variables*)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
      SQL
    end
    nil
  end


end

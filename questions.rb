require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

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
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def authored_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      author_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

end

class Question
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    results.map { |result| Question.new(result) }
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def create
    raise 'already saved!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id)
    INSERT INTO
    questions (title, body, author_id)
    VALUES
    (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_author(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

end

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
end

class Reply
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    results.map { |result| Reply.new(result) }
  end

  attr_accessor :id, :body, :question_id, :author_id, :parent_reply_id

  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @question_id = options['question_i']
    @author_id = options['author_id']
    @parent_reply_id = options['parent_reply_id']
  end

  def create
    raise 'already saved!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, body, question_id, author_id, parent_reply_id)
    INSERT INTO
    replies (body, question_id, author_id, parent_reply_id)
    VALUES
    (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end

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
end

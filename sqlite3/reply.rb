require_relative 'files'

class Reply
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    results.map { |result| Reply.new(result) }
  end

  attr_accessor :id, :body, :question_id, :author_id, :parent_reply_id

  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
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

  def self.find_by_question_id(question_id)

    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL

    results.map {|result| Reply.new(result) }
  end

  def self.find_by_user_id(user_id)

    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
    *
    FROM
    replies
    WHERE
    author_id = ?
    SQL

    results.map {|result| Reply.new(result) }
  end

  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, self.author_id)
    SELECT
    *
    FROM
    users
    WHERE
    id = ?
    SQL

    results.map! {|result| User.new(result) }
    results.first
  end

  def question
    results = QuestionsDatabase.instance.execute(<<-SQL, self.question_id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

    results.map! {|result| Question.new(result) }
    results.first
  end

  def parent
    results = QuestionsDatabase.instance.execute(<<-SQL, self.parent_reply_id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL

    results.map! {|result| Reply.new(result) }
    results.first
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = ?
    SQL

    results.map {|result| Reply.new(result) }
  end

end

require_relative 'files'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
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

  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, self.author_id)
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

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollowerLink.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollowerLink.most_followed_questions(n)
  end

  def likers
    QuestionLikeLink.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLikeLink.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLikeLink.most_liked_questions(n)
  end

end

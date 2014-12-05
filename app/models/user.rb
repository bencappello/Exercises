class User < ActiveRecord::Base

  validates :user_name, :password_digest, :session_token, :presence => true
  validates :session_token, :uniqueness => true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :initialize_session_token

  attr_reader :password

  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :requests,
    :class_name => "CatRentalRequest",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many :sessions

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)

    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def initialize_session_token
    

    # self.session_token ||= self.class.generate_session_token
  end
end

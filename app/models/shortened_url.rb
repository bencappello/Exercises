class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :submitter_id, presence:true


  def self.random_code
    unique = false
    until unique
      code = SecureRandom.urlsafe_base64
      unique = true unless ShortenedUrl.exists?(code)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(submitter_id: user.id, long_url: long_url, short_url: ShortenedUrl.random_code)
  end

  belongs_to(
    :submitter,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )


  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  has_many :visitors, Proc.new { distinct }, :through => :visits, :source => :visitor

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.select(:visitor_id).distinct.where("created_at > ?", 60.minutes.ago).count
  end


end

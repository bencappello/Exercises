class Visit < ActiveRecord::Base
  belongs_to(
    :visitor,
    :class_name => 'User',
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  belongs_to(
    :short_url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :short_url,
    :primary_key => :id
  )

  def self.record_visit!(user, shortened_url)
    Visit.create!(visitor_id: user.id, short_url: shortened_url)
  end




end

class Track < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {scope: :album_id}
  validates :track_type, presence: true, inclusion: { in: ["bonus", "regular"] }

  belongs_to :album
  has_one :band, through: :album
end

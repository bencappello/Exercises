class Album < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :album_type, presence: true, inclusion: { in: ["live", "studio"] }

  belongs_to :band
  has_many :tracks, dependent: :destroy
end

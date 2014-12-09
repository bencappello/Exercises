class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator, class_name: 'User'
  has_many :post_subs,
    inverse_of: :sub,
    dependent: :destroy,
    class_name: 'PostSub',
    foreign_key: :sub_id

  has_many :posts, through: :post_subs
end

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :title, uniqueness: true

  has_many :post_subs,
    inverse_of: :post,
    dependent: :destroy,
    class_name: 'PostSub',
    foreign_key: :post_id

  has_many :subs, through: :post_subs, source: :sub
  belongs_to :author,
    class_name: "User",
    inverse_of: :posts

  has_many :comments



  def update_subs(new_sub_ids)
    new_sub_ids.delete("")
    new_sub_ids.map!(&:to_i)
    old_sub_ids = self.subs.pluck(:id)
    ids_to_add = new_sub_ids - old_sub_ids
    ids_to_remove = old_sub_ids - new_sub_ids
    transaction do
      ids_to_add.each do |id|
        PostSub.create!(post_id: self.id, sub_id: id)
      end

      ids_to_remove.each do |id|
        PostSub.find_by(post_id: self.id, sub_id: id).destroy
      end
    end
  end
end

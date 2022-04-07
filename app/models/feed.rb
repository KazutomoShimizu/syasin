class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
end

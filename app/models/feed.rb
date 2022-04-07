class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
end

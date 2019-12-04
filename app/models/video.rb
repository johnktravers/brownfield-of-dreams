class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates :tutorial, :presence => true

  validates_presence_of :title,
                  :description,
                    :thumbnail
end

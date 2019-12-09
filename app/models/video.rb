class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates :tutorial, :presence => true

  validates_presence_of :title,
                  :description,
                    :thumbnail,
                     :position

  validates_numericality_of :position, only_integer: true

end

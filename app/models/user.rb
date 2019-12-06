class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name
  enum role: [:default, :admin]
  has_secure_password

  def self.find_and_update(user_info, user_id)
    find_by(id: user_id).update(provider: user_info.provider,
                                          uid: user_info.uid,
                          token: user_info.credentials.token
    )
  end
end

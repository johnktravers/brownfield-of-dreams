class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name
  enum role: [:default, :admin]
  has_secure_password

  def update_github(user_info)
    update(
      github_username: user_info['extra']['raw_info']['login'],
      github_id: user_info['uid'],
      github_token: user_info['credentials']['token']
    )
  end
end

require 'securerandom'

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships,
            class_name: 'Friendship',
            foreign_key: 'friend_id'
  has_many :inverse_friends,
            through: :inverse_friendships,
            source: :user

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name, :last_name
  enum role: [:default, :admin]
  has_secure_password

  after_save :generate_token

  def generate_token
    self.activation_token = SecureRandom.hex(10)
  end

  def activate
    update(active?: true)
  end

  def status
    return 'Active' if active?
    'Inactive'
  end

  def all_friends
    all_friends = friends + inverse_friends
    all_friends.uniq.flatten
  end

  def has_friend?(friend_id)
    all_friends.any? { |friend| friend.id == friend_id }
  end

  def update_github(user_info)
    update(
      github_username: user_info['extra']['raw_info']['login'],
      github_id: user_info['uid'],
      github_token: user_info['credentials']['token']
    )
  end

  def bookmark_data
    ActiveRecord::Base.connection.execute(
      "SELECT tutorials.title as tutorial_title, tutorials.id as tutorial_id, videos.title as video_title, videos.position as video_position, videos.id AS video_id
        FROM videos
        INNER JOIN tutorials ON videos.tutorial_id = tutorials.id
        INNER JOIN user_videos ON user_videos.video_id = videos.id
        WHERE user_videos.user_id = #{id}
        ORDER BY tutorial_id, videos.position"
    )
  end
end

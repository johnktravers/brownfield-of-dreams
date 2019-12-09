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

  def bookmarks
    results = ActiveRecord::Base.connection.execute(
      "SELECT tutorials.title as tutorial_title, tutorials.id as tutorial_id, videos.title as video_title, videos.position as video_position
        FROM videos
        INNER JOIN tutorials ON videos.tutorial_id = tutorials.id
        INNER JOIN user_videos ON user_videos.video_id = videos.id
        WHERE user_videos.user_id = 2
        ORDER BY tutorial_id, videos.id"
    )

    bookmarks = []

    tutorials = results.map do |result|
      [result['tutorial_id'], result['']]
    end

    tutorials.each do |result|
      Bookmark.new(result)
    end
  end
end

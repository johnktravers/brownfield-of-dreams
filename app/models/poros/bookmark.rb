class Bookmark
  attr_reader :tutorial_title, :videos

  def initialize(attrs)
    @tutorial_title = attrs['tutorial_title']
    @videos = []
  end

  def add_video(video_title, video_position)
    videos << [video_title, video_position]
  end
end

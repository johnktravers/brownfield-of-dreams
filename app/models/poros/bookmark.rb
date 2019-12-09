class Bookmark
  attr_reader :tutorial_title, :tutorial_id, :videos

  def initialize(attrs)
    @tutorial_id = attrs[0]
    @tutorial_title = attrs[1]
    @videos = []
  end

  def add_video(results)
    @videos << BookmarkVideo.new(results)
  end
end

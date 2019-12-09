class BookmarkVideo
  attr_reader :title, :position, :id

  def initialize(results)
    @title = results['video_title']
    @position = results['video_position']
    @id = results['video_id']
  end
end

class BookmarkFacade
  attr_reader :bookmarks

  def initialize(user)
    @results = user.bookmark_data
    @bookmarks = import_videos
  end

  def tutorials
    @results.map do |result|
      [result['tutorial_id'], result['tutorial_title']]
    end.uniq
  end

  def generate_bookmarks
    tutorials.map do |result|
      Bookmark.new(result)
    end
  end

  def import_videos
    generate_bookmarks.each do |bookmark|
      @results.each do |result|
        if result['tutorial_id'] == bookmark.tutorial_id
          bookmark.add_video(result)
        end
      end
    end
  end
end

module YouTube
  class Video
    attr_reader :thumbnail

    def initialize(id)
      data = by_id(id)
      @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
    end

    def by_id(id)
      new(YoutubeService.new.video_info(id))
    end
  end
end

require 'rails_helper'

RSpec.describe YouTube::Video, type: :model do
  it 'initialize' do
    VCR.use_cassette('youtube_video_info') do
      service = YoutubeService.new
      video = YouTube::Video.new(service.video_info('WPPPFqsECz0'))

      expect(video.thumbnail)
        .to eq('https://i.ytimg.com/vi/WPPPFqsECz0/hqdefault.jpg')
    end
  end
end

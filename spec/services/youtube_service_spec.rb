require 'rails_helper'

RSpec.describe YoutubeService, type: :service do
  describe 'instance methods' do
    it 'video_info' do
      VCR.use_cassette('youtube_video_info') do
        service = YoutubeService.new

        expect(service.video_info('WPPPFqsECz0').keys)
          .to eq([:kind, :etag, :pageInfo, :items])
        expect(service.video_info('WPPPFqsECz0')[:items][0][:snippet][:title])
          .to eq('An Antidote to Dissatisfaction')
        expect(service.video_info('WPPPFqsECz0')[:items][0][:snippet][:description])
          .to include('Everybody is familiar with the feeling that things are not as they should be.')
      end
    end
  end
end

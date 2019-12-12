require 'rails_helper'

RSpec.describe BookmarkVideo, type: :model do
  it 'initialize' do
    attrs = {
      'video_title' => 'The Best Video Ever',
      'video_position' => 3,
      'video_id' => 12
    }
    bookmark_video = BookmarkVideo.new(attrs)

    expect(bookmark_video).to be_a(BookmarkVideo)
    expect(bookmark_video.title).to eq('The Best Video Ever')
    expect(bookmark_video.position).to eq(3)
    expect(bookmark_video.id).to eq(12)
  end
end

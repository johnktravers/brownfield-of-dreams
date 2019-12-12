require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  before :each do
    @bookmark = Bookmark.new([4, 'How to Be a Good Person'])
  end

  it 'initialize' do
    expect(@bookmark).to be_a(Bookmark)
    expect(@bookmark.tutorial_id).to eq(4)
    expect(@bookmark.tutorial_title).to eq('How to Be a Good Person')
    expect(@bookmark.videos).to eq([])
  end

  it 'add_video' do
    attrs = {
      'video_title' => 'The Best Video Ever',
      'video_position' => 3,
      'video_id' => 12
    }
    @bookmark.add_video(attrs)

    expect(@bookmark.videos.length).to eq(1)
    expect(@bookmark.videos.first).to be_a(BookmarkVideo)
    expect(@bookmark.videos.first.title).to eq('The Best Video Ever')
    expect(@bookmark.videos.first.position).to eq(3)
    expect(@bookmark.videos.first.id).to eq(12)
  end
end

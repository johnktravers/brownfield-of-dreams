require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many(:videos).through(:user_videos) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(
        email: 'user@email.com',
        password: 'password',
        first_name: 'Jim',
        role: 0
      )

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(
        email: 'admin@email.com',
        password: 'admin',
        first_name: 'Bob',
        role: 1
      )

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    before :each do
      @user = create(:user)
    end

    it 'generate_token' do
      expect(@user.activation_token.length).to eq(20)
      expect(@user.activation_token.scan(/\A[a-f0-9]+\Z/i).first)
        .to eq(@user.activation_token)
    end

    it 'activate' do
      @user.activate

      expect(@user.active?).to eq(true)
    end

    it 'status' do
      expect(@user.status).to eq('Inactive')

      @user.activate

      expect(@user.status).to eq('Active')
    end

    it 'all_friends' do
      user2 = create(:user)
      user3 = create(:user)
      user4 = create(:user)
      create(:friendship, user_id: @user.id, friend_id: user2.id)
      create(:friendship, user_id: @user.id, friend_id: user3.id)
      create(:friendship, user_id: user4.id, friend_id: @user.id)

      expect(@user.all_friends).to eq([user2, user3, user4])
    end

    it 'has_friend?' do
      expect(@user.has_friend?(12)).to eq(false)

      user2 = create(:user)
      create(:friendship, user_id: @user.id, friend_id: user2.id)

      expect(@user.has_friend?(user2.id)).to eq(false)
    end

    it 'update_github' do
      oauth_hash = {
        'provider' => 'github',
        'uid' => '46035439',
        'credentials' => {
          'token' => ENV['GITHUB_ACCESS_TOKEN'],
          'expires' => false
        },
        'extra' => {
          'raw_info' => {
            'login' => 'johnktravers',
            'id' => 46_035_439
          }
        }
      }

      @user.update_github(oauth_hash)

      expect(@user.github_username).to eq('johnktravers')
      expect(@user.github_id).to eq('46035439')
      expect(@user.github_token).to eq(ENV['GITHUB_ACCESS_TOKEN'])
    end

    it 'bookmark_data' do
      tutorial1 = create(:tutorial)
      video1 = create(:video, tutorial: tutorial1)
      tutorial2 = create(:tutorial)
      create_list(:video, 3, tutorial: tutorial2)
      video2 = create(:video, tutorial: tutorial2)
      create(:user_video, user: @user, video: video1)
      create(:user_video, user: @user, video: video2)

      expect(@user.bookmark_data.to_a).to eq(
        [
          {
            'tutorial_id' => tutorial1.id,
            'tutorial_title' => tutorial1.title,
            'video_id' => video1.id,
            'video_position' => video1.position,
            'video_title' => video1.title
          },
          {
            'tutorial_id' => tutorial2.id,
            'tutorial_title' => tutorial2.title,
            'video_id' => video2.id,
            'video_position' => video2.position,
            'video_title' => video2.title
          }
        ]
      )
    end
  end
end

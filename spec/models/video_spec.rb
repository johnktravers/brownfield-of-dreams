require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'Relationships' do
    it { should belong_to :tutorial }
    it { should have_many :user_videos }
    it { should have_many(:users).through(:user_videos) }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :thumbnail }
    it { should validate_presence_of :position }
    it { should validate_numericality_of(:position).only_integer }
  end
end

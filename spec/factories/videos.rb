FactoryBot.define do
  factory :video do
    title { Faker::Pokemon.name }
    description { Faker::SiliconValley.motto }
    thumbnail do
      'http://cdn3-www.dogtime.com/assets/uploads/2011/03/'\
      'puppy-development-460x306.jpg'
    end
    video_id { Faker::Crypto.md5 }
    position { 0 }
    tutorial
  end
end

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
  end

  factory :admin, parent: :user do
    role { :admin }
  end

  factory :github_user, parent: :user do
    github_token { ENV["GITHUB_ACCESS_TOKEN"] }
    github_id { "46035439" }
    github_username { "johnktravers" }
  end
end

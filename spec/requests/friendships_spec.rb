require 'rails_helper'

RSpec.describe 'Create User Friendships' do

  it 'cannot create a friendship with an invalid friend id' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    post '/friendships/2359632'

    expect(response.body).to include('The page you were looking for doesn\'t exist (404)')
  end

end

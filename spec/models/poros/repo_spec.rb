require 'rails_helper'

RSpec.describe Repo, type: :model do
  it 'initialize' do
    repo_data = {
      name: 'my_repo',
      html_url: 'https://github.com/user/my_repo'
    }
    repo = Repo.new(repo_data)

    expect(repo).to be_a(Repo)
    expect(repo.name).to eq('my_repo')
    expect(repo.url).to eq('https://github.com/user/my_repo')
  end
end

class AddGithubInfotoUsers < ActiveRecord::Migration[5.2]
  def change
      add_column :users, :github_username, :string
      add_column :users, :github_id, :string
      add_column :users, :github_token, :string
  end
end

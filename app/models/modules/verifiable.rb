module Verifiable
  def has_account?
    user_id != nil
  end

  def find_user_id
    user = User.find_by(github_id: github_id)
    user&.id
  end
end

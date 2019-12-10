class UsersController < ApplicationController
  def show
    @github_facade = GithubFacade.new(current_user) if github_connection
    @bookmark_facade = BookmarkFacade.new(current_user) if current_user.user_videos.any?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.first_name} #{@user.last_name}"
      flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end

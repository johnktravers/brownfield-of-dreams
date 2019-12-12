class UsersController < ApplicationController
  def show
    @github_facade = GithubFacade.new(current_user) if github_connection
    if current_user.user_videos.any?
      @bookmark_facade = BookmarkFacade.new(current_user)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash_and_send_activation_email(@user)
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if current_user.activation_token == params[:activation_token]
      current_user.activate
      flash[:success] = 'Thank you! Your account is now activated.'
    else
      flash[:alert] = 'Your activation token is invalid, '\
        'please contact support.'
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def flash_and_send_activation_email(user)
    flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
    flash[:notice] = 'This account has not yet been activated. '\
      'Please check your email.'

    UserMailer.activate(user).deliver_later
    redirect_to dashboard_path
  end
end

class InviteController < ApplicationController
  def new; end

  def create
    @github_facade = GithubFacade.new(current_user)
    invitee = @github_facade.invitee(invite_params[:github_handle])
    if invitee.email && invitee.name
      send_invite_mail(invitee)
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:notice] = 'The Github user you selected doesn\'t have an '\
        'email address associated with their account.'
    end
    redirect_to dashboard_path
  end

  private

  def invite_params
    params.require(:invite).permit(:github_handle)
  end

  def send_invite_mail(invitee)
    UserMailer
      .invite(invitee.email, invitee.name, current_user)
      .deliver_later
  end
end

class UserMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: 'Activate Your Account')
  end

  def invite(invitee_email, invitee_name, user)
    @user = user
    @invitee = [invitee_email, invitee_name]
    mail(to: invitee_email, subject: 'Join your friends on Brownfield!')
  end
end

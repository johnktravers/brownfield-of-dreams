class UserMailer < ApplicationMailer
  def activation(user)
    @user = user
    mail(to: user.email, subject: "Activate Your Account")
  end
end

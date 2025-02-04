class UserMailer < ApplicationMailer
  def confirmation_instructions(user)
    @user = user
    mail(to: @user.email, subject: "Confirmation Email")
  end
end
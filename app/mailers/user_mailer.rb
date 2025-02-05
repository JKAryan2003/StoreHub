class UserMailer < Devise::Mailer
  def confirmation_instructions(user)
    @user = user
    mail(to: @user.email, subject: "Confirmation Email")
  end
end
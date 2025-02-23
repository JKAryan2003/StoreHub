class OrderMailer < ApplicationMailer

  def order_confirmation_mail(current_user)
    @current_user = current_user
    mail(to: @current_user.email, subject: "Order Confirmation Email")
  end

  def order_placed_mail(current_user, current_order)
    @current_order = current_order
    @current_user = current_user
    mail(to: @current_user.email, subject: "Order Placed Email")
  end

  def order_cancel_mail(current_user)
    @current_user = current_user
    mail(to: @current_user.email, subject: "Order Cancellation Email")
  end
end

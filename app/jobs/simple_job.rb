require 'sidekiq'


class SimpleJob
  include Sidekiq::Job

  def perform(current_user, current_order)
    OrderMailer.order_confirmation_mail(current_user, current_order)
    puts "Sidekiq job started by Aryan"
  end
end


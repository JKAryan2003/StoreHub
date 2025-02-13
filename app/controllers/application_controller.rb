class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pundit::Authorization

  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # before_action :set_render_cart
  # before_action :initialize_cart

  # def set_render_cart
  #   @render_cart = true
  # end

  # def initialize_cart
  #   @cart ||= Cart.find_by(id: session[:cart_id])

  #   if @cart.nil?
  #     @cart = Cart.create(user: current_user)
  #     session[:cart_id] = @cart.id
  #   end
  # end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end

end

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :create_cart
  allow_browser versions: :modern
  include Pundit::Authorization

  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def create_cart
    if user_signed_in?
      @cart ||= Cart.find_by(user_id: current_user.id)
      
      if @cart.nil?
        @cart = Cart.create(user_id: current_user.id) 
        session[:cart_id] = @cart.id 
      end
    else
      @cart ||= Cart.find_by(id: session[:cart_id]) 
      if @cart.nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id 
      end
    end
  end  

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end

end

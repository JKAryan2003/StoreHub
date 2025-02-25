# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.blank?
      redirect_to new_user_session_path, alert: "Email can't be blank"
    elsif @user.inactive?
      redirect_to new_user_session_path, notice: "You are not an active user"
    else
      super
    end

  end

  def after_sign_out_path_for(resource_or_scope)
    root_path 
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:first_name, :last_name, :email, :phone_number, :status])
  end
end

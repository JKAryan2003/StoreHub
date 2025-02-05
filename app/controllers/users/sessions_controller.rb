# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.inactive?
      redirect_to new_user_session_path, notice: "You are not an active user"
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super do |resource|
  #     redirect_to new_user_registration_path
  #   end
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:first_name, :last_name, :email, :phone_number, :status])
  end
end

class UsersController < ApplicationController
  # before_action :require_login, only: [:index, :show, :edit, :update]
  # before_action :require_admin, only: [:index]

  def index
    @users = User.all
    authorize @users
    @pagy, @users = pagy(@users, limit: 5)
  end

  def edit
    user
    authorize @user
    @roles = Role.all
  end

  def update
    @roles = Role.all
    role_ids = params[:user][:roles]
    if user.update(user_params)
      role_ids.each do |role_id|
        if !UserRole.find_by(user_id: user.id, role_id: role_id)
          UserRole.create(user_id: @user.id, role_id: role_id)
        end
      end

      prev_ids = user.roles.map{ |role| role.id}

      prev_ids.each do |prev_role_id|
        if !role_ids.include?(prev_role_id.to_s)
          UserRole.find_by(user_id: user.id, role_id: prev_role_id).destroy
        end
      end
      redirect_to root_path, notice: "Updated!!"

    else
      render :edit
    end
  end

  def show
    user
    if user != current_user
      authorize user
    end
    @roles = user.roles
  end

  def destroy
    user
    user.destroy
    redirect_to users_path
    
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, role_ids: [])
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end
end

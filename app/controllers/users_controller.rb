class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def index

    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, view_context: view_context) }
    end

    authorize User.all
  end
  
  def edit
    user
    if user != current_user
      authorize user
    end
    @roles = Role.all
  end

  def update
    user
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

  def my_products
    @my_products = current_user.products
  end
  
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :status)
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end

  def role_params
    params.require(:user).permit(roles:[])
  end

end

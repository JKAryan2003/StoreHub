class RolesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def index
    @roles = Role.all
    authorize @roles
  end

  def show
    authorize role
    role
  end

  def new
    @role = Role.new
    authorize @role
  end

  def edit
    role
    authorize role
  end

  def create
    @role = Role.new(role_params)   

    if @role.save
      redirect_to roles_path, notice: "User Created Successfully!"
    else
      flash.now[:alert] = @role.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end
  end

  def update
    role

    if role.update(role_params)
      redirect_to roles_path, notice: "Updated!!"
    else
      render :edit
    end
  end

  def destroy
    role
    role.destroy()
    redirect_to roles_path
  end

  private

  def role_params
    params.require(:role).permit(:role_name,:description)
  end

  def role
    @role ||= Role.find_by(id: params[:id])
  end
end

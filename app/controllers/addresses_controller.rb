class AddressesController < ApplicationController

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    
    if @address.save
      redirect_to carts_path, notice: "Address Created Successfully!"
    else
      flash.now[:alert] = @address.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end
  end

  def update

  end

  def destroy
    address = Address.find_by(id: params[:id])
    address.destroy
  end

  private

  def address_params
    params.require(:address).permit(:recipient_name, :street, :city, :state, :zip_code, :phone_number, :default_address)
  end

end
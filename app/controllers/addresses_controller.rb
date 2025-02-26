class AddressesController < ApplicationController

  def create

    if params[:address][:id].blank?
      @address = Address.new(address_params)
      @address.user = current_user
      change_default
      if @address.save
        redirect_to checkout_path, notice: "Address Created Successfully!"
      else
        flash.now[:alert] = @address.errors.full_messages.to_sentence
        render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
      end
    else
      @address = Address.find_by(id: params[:address][:id])
      change_default
    
      if @address.update(address_params)
        redirect_to checkout_path, notice: "Address Updated Successfully!"
      else
        flash.now[:alert] = @address.errors.full_messages.to_sentence
        render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
      end
    end

    
  end

  def destroy
    address = Address.find_by(id: params[:id])
    address.destroy
  end

  private

  def address_params
    params.require(:address).permit(:recipient_name, :street, :city, :state, :zip_code, :phone_number, :default_address)
  end

  def change_default
    if params[:address][:default_address] == true
      addresses = current_user.addresses
      addresses.where(default_address: true).update(default_address: false)
    end
  end
end
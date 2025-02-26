document.addEventListener('DOMContentLoaded', function () {
  const buttons = document.querySelectorAll('[data-bs-toggle="modal"]');
  buttons.forEach(button => {
    button.addEventListener('click', function () {
      const addressId = this.getAttribute('data-id');
      const addressRecipientName = this.getAttribute('data-recipient_name');
      const addressStreet = this.getAttribute('data-street');
      const addressCity = this.getAttribute('data-city');
      const addressState = this.getAttribute('data-state');
      const addressZipCode = this.getAttribute('data-zip_code');
      const addressPhoneNumber = this.getAttribute('data-phone_number');
      const addressDefaultAddress = this.getAttribute('data-default_address');

      const addressIdElement = document.getElementById('address_id');
      const addressRecipientNameElement = document.getElementById('address_recipient_name');
      const addressStreetElement = document.getElementById('address_street');
      const addressCityElement = document.getElementById('address_city')
      const addressStateElement = document.getElementById('address_state');
      const addressZipCodeElement = document.getElementById('address_zip_code');
      const addressPhoneNumberElement = document.getElementById('address_phone_number');
      const addressDefaultAddressElement = document.getElementById('address_default_address');

      if (addressIdElement){
        addressIdElement.value = addressId;
        addressRecipientNameElement.value = addressRecipientName;
        addressStreetElement.value = addressStreet;
        addressCityElement.value = addressCity;
        addressStateElement.value = addressState;
        addressZipCodeElement.value = addressZipCode;
        addressPhoneNumberElement.value = addressPhoneNumber;
        addressDefaultAddressElement.value = addressDefaultAddress;
      }
    });
  });
});

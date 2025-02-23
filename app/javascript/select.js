document.addEventListener('DOMContentLoaded', function () {
  const dropdown = document.getElementById("status");

  dropdown.addEventListener("change", function() {
    
    document.getElementById("myForm").submit();
  });

});
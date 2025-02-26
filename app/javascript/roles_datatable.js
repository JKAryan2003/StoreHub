jQuery(document).ready(function() {
  $('#roles-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $('#roles-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "id"},
      {"data": "role_name"},
      {"data": "description"},
      {"data": "actions"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});
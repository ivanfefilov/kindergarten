$ ->
  $('#usersTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#usersTable').data('source')
    pagingType: 'full_numbers'

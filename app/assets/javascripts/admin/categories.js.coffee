$ ->
  $('#categoriesTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#categoriesTable').data('source')
    pagingType: 'full_numbers'

$ ->
  $('#posts-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#posts-table').data('source')
    pagingType: 'full_numbers'

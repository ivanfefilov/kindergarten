$ ->
  $('#posts-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#posts-table').data('source')
    pagingType: 'full_numbers'
  
  $('#game-items-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#game-items-table').data('source')
    pagingType: 'full_numbers'  

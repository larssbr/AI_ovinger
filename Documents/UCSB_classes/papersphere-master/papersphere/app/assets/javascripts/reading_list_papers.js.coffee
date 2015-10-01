# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # Sets up the stars to match the data when the page is loaded
  checkedId = $("form.rating_ballot > input:checked").attr "id"
  $("form.rating_ballot > label[for=" + checkedId + "]").prevAll().andSelf().addClass "bright"
  
  # Makes stars glow on hover
  $("form.rating_ballot > label").hover (-> # mouseover
      $(this).prevAll().andSelf().addClass "glow"
    ), -> # mouseout
      $(this).siblings().andSelf().removeClass "glow"

  # Makes stars stay glowing after click
  $("form.rating_ballot > label").click ->
    $(this).siblings().removeClass "bright"
    $(this).prevAll().andSelf().addClass "bright"

  # Submits the form (saves data) after user makes a change.
  $('form.rating_ballot').change ->
    $('form.rating_ballot').submit()
    
  # Handles loading more comments dynamically
  $('.load-comments-button').click (e) ->
    e.preventDefault()
    loadCommentsButton = $(this)
    commentsDisplayedSoFar = $('table.comments-table tbody').find('tr').size()
    readingListPaperId = $('form.comment-form input#reading_list_paper_id').val()
    dataToSend = {
      'reading_list_paper_id': readingListPaperId,
      'comments_offset': commentsDisplayedSoFar
    }
    $.ajax '/comments',
      type: 'GET'
      dataType: 'json'
      data: dataToSend
      error: (jqXHR, textStatus, errorThrown) ->
        # deal with error
        console.log "Load Comments AJAX Error: #{textStatus}"
        console.log "#{errorThrown}"
        console.log "#{jqXHR}"
      success: (data, textStatus, jqXHR) ->
        # deal with success
        if data? and Object.keys(data).length > 0
          for k,comment of data
            $('table.comments-table tbody').append comment
        else
          noMoreCommentsMessage = "<p>No more comments to load.</p>"
          loadCommentsButton.replaceWith noMoreCommentsMessage
    false
        
    
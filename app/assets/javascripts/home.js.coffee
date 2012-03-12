# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#event_calendar_date").datepicker({ dateFormat: "dd/mm/yy", firstDay: 1})
  $('#slider_button').click ->
    $('#new_event_div').slideToggle('slow')
    if $(this).html() == "create event"
      $(this).html("hide panel")
    else
      $(this).html("create event")
  $("#event_content").tinymce({mode: 'textareas', theme: 'advanced'})

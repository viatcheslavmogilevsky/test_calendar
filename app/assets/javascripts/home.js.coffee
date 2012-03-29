# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#event_calendar_date").datepicker({ dateFormat: "dd/mm/yy", firstDay: 1})
  $("#event_content").tinymce({mode: 'textareas', theme: 'advanced'})

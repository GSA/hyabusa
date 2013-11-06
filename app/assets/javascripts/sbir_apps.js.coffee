# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # Tooltips
  if gon.myusa_form_tooltips
    gon.myusa_form_tooltips.map( (tooltip) ->
      tipElement = "#data_" + tooltip
      $(tipElement).tooltip({trigger:'focus', placement: 'right', container: 'body', html: true})
    )


#$ ->
#  $().tooltip()
#  
   

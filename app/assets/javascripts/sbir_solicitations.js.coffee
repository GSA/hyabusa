# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  # initialize special field widgets
  $('#open_dt').datepicker()
  $('#close_dt').datepicker()
  $('#posted_dt').datepicker()

  $('#listing_url').tooltip()
  $('#participating_organizations').tooltip()
  $('#summary').tooltip()



  # disable all but the solnbr field
  $('input,textarea').prop('disabled', true)
  $('#solnbr').prop('disabled', false)

  # on blur:
  # make the request to our local prepopulate endpoint.
  # show a spinner
  # prepopulate or show a mild error message
  set_input = (key, data) ->
    if key.indexOf('_dt') == -1
      $('#' + key).val(data[key])
    else
      $("#" + key).datepicker('update', new Date(Date.parse(data[key])))

  prepopulate_form = (response) ->
    data = response.response['docs'][0]

    input_keys = ['listing_url', 'title', 'close_dt', 'agency', 'participating_organizations', 'summary', 'description']
    set_input(key, data) for key in input_keys

  $("input[name='solnbr']").on("blur", ->
    if this.value != ''
      $('input,textarea').prop('disabled', false)
      $.get("/sbir_solicitations/" + this.value + "/prepopulate.json", (data) ->
        prepopulate_form(data)
      )
  )

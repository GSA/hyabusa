# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  # initialize special field widgets
  $('#open_dt').datepicker("setDate", new Date())
  $('#close_dt').datepicker()
  $('#posted_dt').datepicker("setDate", new Date())

  $('#listing_url').tooltip()
  $('#participating_organizations').tooltip()
  $('#summary').tooltip()

  $('#fbopen-alert').alert()
  $('#fbopen-alert').hide()

  $('#fbopen-info').alert()
  $('#fbopen-info').hide()

  # disable all but the solnbr field
  $('input,textarea').prop('disabled', true)
  $('#solnbr').prop('disabled', false)

  $('#fbopen-alert,#fbopen-info').on("close.bs.alert", ->
    $('.new-solicitation')[0].reset()
    $('#solnbr').focus()
  )

  $('#fbopen-alert').on("prepopulate", ->
    $(this).show()
  )


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

  $("#solnbr").on("blur", ->
    if this.value != ''
      $('input,textarea').prop('disabled', false)
      $.get("/sbir_solicitations/" + this.value + "/prepopulate.json", (data) ->
        prepopulate_form(data)
        $('#fbopen-alert').trigger("prepopulate")
        $('#listing_url').focus()
      ).fail( ->
        $('#fbopen-info').show()
        $('#listing_url').focus()
      )
  )

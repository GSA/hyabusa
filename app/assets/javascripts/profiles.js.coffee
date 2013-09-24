# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    fieldset = $(this).parents('fieldset')
    hidden_destroy = $(fieldset).find(':hidden').find('[id$=destroy]')
    $(hidden_destroy).val('1')
    $(fieldset).hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
$ ->
  $('.naics-typeahead').typeahead({
    name: 'naics', 
    local: gon.naics_codes, 
    limit: 10000,
    template: '
      <p class="tt-option"><strong>{{name}}</strong> ({{value}})</p>
      <p class="tt-description tt-option"><em>{{description}}</p>
    ',
    engine: Hogan
  })


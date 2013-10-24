# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.naics-typeahead').typeahead({
    name: 'naics', 
    local: gon.naics_codes, 
    limit: 10000,
    template: '<p class="tt-option"><strong>{{name}}</strong> ({{value}})</p>',
    engine: Hogan
  })


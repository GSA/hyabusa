(function( modusOperandi, $, undefined ) {
    modusOperandi.getOps = function(url) {
      $.get( url, function(data) {
        // fill in values for name and desc
        $('#oper-name').html(data['name']).addClass('ajax-loaded')
        $('#oper-description').html(data['description']).addClass('ajax-loaded')

        // create placeholder div for operations
        $html = $('<div/>', { id: 'ops' })
        $('#operations').append($html)

        // generate the operations (recursively)
        generateOpsRecursively(data);

        // markup help
        $('#operations').addClass('ajax-loaded')
        $('#ops div').first().addClass('first')
        var top_level_step = 0
        $('#ops .level-0').each(function() {
          top_level_step++
          $('<span class="step step-'+top_level_step+'">'+top_level_step+'<span>').appendTo($(this))
        })

        // display!
        $('.loading').hide()
        $('.ajax-loaded').fadeIn()
      });
    };

    function generateOpsRecursively(data,elm) {
      $.each( data['children'], function(k,v) {
        $elm = makeOperation(k,v)
        if (elm) { $elm.appendTo(elm) }
        else { $('#ops').append($elm) }
        $elm.addClass('level-'+$elm.parents('.op').length)
        generateOpsRecursively(v,$elm)
      });
    };

    function makeOperation(k,v) {
      $elm = $('<div class="op"></div>')
      $elm.html('<span class="title">'+v['name']+'</span>')
      if (v['description']) { $('<p>'+v['description']+'</p>').appendTo($elm) }
      if (v['dependencies']) { $('<p class="dependencies">'+v['dependencies']+'</p>').appendTo($elm) }
      if (v['whats_next']) { $('<p class="whats-next">'+v['whats_next']+'</p>').appendTo($elm) }
      if (v['links']) {
        $.each( v['links'], function(k,v) {
          $('<a href="'+v['url']+'">'+v['name']+'</a>').appendTo($elm)
        })
      }
      if (v['dependencies']) { addFilter($elm,'external-dependency') }
      if (v['whats-next']) { addFilter($elm,'whats-next') }

      $('<br clear="both">').appendTo($elm)
      return $elm
    };

    function addFilter(elm,filter) {
      current_filters = elm.data('filters')
      if (current_filters) new_filters = current_filters + ' ' + filter
      else new_filters = filter
      return elm.data('filters',new_filters)
    };

}( window.modusOperandi = window.modusOperandi || {}, jQuery ));
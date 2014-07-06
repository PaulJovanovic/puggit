// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  var channels = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/channels/search?query=%QUERY',
      filter: function (channels) {
        return $.map(channels, function (channel) {
          return {
            id: channel.id,
            name: channel.name,
            tokens: channel.name.split(" "),
          };
        });
      }
    }
  });

  channels.initialize();

  $('.js-search-channels').typeahead(null, {
    name: 'channels',
    source: channels.ttAdapter(),
    minLength: 2,
    templates: {
      suggestion: Handlebars.compile([
        '<table class="full-width">',
        '<tr>',
        '<td class="plxs fwl">{{name}}</td>',
        '</tr>',
        '</table>'
      ].join(''))
    }
  }).on('typeahead:selected', function(event, selection) {
    $(".js-quote-citable-id").val(selection.id);
    $(".js-search-channels").val(selection.name).change();
  });
});

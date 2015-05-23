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
    $.ajax({
      type: "post",
      url: "/user_channels",
      data: {
        channel_id: selection.id
      }
    }).success(function(data) {
      $('<div class="relative bss bwts-plus bc-5 pointer hover-action js-theatre-channel" data-id="' + data.id + '" data-channel-id="' + data.channel.id + '" data-channel-name="' + data.channel.name + '" data-active=false><div class="paxs bg-4 bg-6-active c-11 c-14-hover c-14-active bss bwbs bc-2 nowrap" style="overflow: hidden;text-overflow: ellipsis;">' + data.channel.name+ '</div><div class="absolute top right bottom c-1 c-blue-hover hover-action-show js-theatre-channel-remove"><table class="full-height"><tbody><tr><td class="phxxxs"><i class="fa fa-times fss"></i></td></tr></tbody></table><div class="hide"><form accept-charset="UTF-8" action="/user_channels/' + data.channel.id + '" class="js-theatre-channel-remove-form" data-remote="true" id="edit_user_channel_' + data.channel.id + '" method="post"><div style="display:none"><input name="utf8" type="hidden" value="✓"><input name="_method" type="hidden" value="delete"></div><input name="commit" type="submit" value="remove"></form></div></div></div>').prependTo($(".js-theatre-channels")).click().fadeIn();
    });
  });
});

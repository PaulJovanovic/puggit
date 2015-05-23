streams = []
stream_order = []
stream_index = 0

shuffle = (a) ->
  for i in [a.length-1..1]
    j = Math.floor Math.random() * (i + 1)
    [a[i], a[j]] = [a[j], a[i]]
  a

nextStream = ->
  if stream_index == stream_order.length - 1
    stream_index = 0
  else
    stream_index++

loadStream = ->
  stream_name = stream_order[stream_index]
  $.ajax(
    type: "GET"
    url: "/streams/status"
    data:
      name: stream_name
  ).success( (data)->
    $(".js-channel-status").html(streams[stream_name].status).attr("title", streams[stream_name].status)
    $(".js-channel-display-name").html(streams[stream_name].display_name)
    $(".js-channel-logo").attr("src", streams[stream_name].logo).removeClass("hide")
    $(".js-theatre-controller").removeClass("invisible")
    onlineChecker = ""

    clearInterval(onlineChecker)

    flash_vars =
      embed: 1
      channel: stream_name
      auto_play: "true"

    params =
      allowScriptAccess: "always"
      allowFullScreen: "true"

    swfobject.embedSWF("http://www-cdn.jtvnw.net/swflibs/TwitchPlayer.swf", "twitch_embed_player", "100%", "100%", "11", null, flash_vars, params)
  ).fail(->
    loadNextStream()
  )

loadNextStream = ->
  nextStream()
  loadStream()

$(document).ready ->
  $("body").on "click", ".js-theatre-channel", ->
    $channel = $(@)
    if !$channel.hasClass("active")
      $(".js-theatre-channel.active").removeClass("active")
      $channel.addClass("active")

      $.ajax
        type: "POST"
        url: "/user_channels/#{$channel.data("id")}/activate"

      $.ajax(
        type: "GET"
        url: "/streams/search"
        data:
          query: $channel.data("channel-name")
        dataType: "json"
      ).success (data)->
        streams = data
        stream_index = 0
        stream_order = shuffle(Object.keys(streams))
        loadStream()
        # setTimeout( ->
        #   player = $("#twitch_embed_player")[0]
        #   onlineChecker = setInterval( ->
        #   , 60000)
        # , 60000)

  $(".js-theatre-skip").click ->
    loadNextStream()

  $("body").on "click", ".js-theatre-channel-remove", (e) ->
    e.stopPropagation()
    $channel = $(@).closest(".js-theatre-channel")
    channelWasActive = $channel.hasClass("active")

    $(@).find(".js-theatre-channel-remove-form").submit()

    $channel.animate {height: "0px"}, 400, ->
      $(@).remove()
      if channelWasActive
        $(".js-theatre-channel:first").click()

  if $(".js-theatre-channel").length > 0
    $(".js-theatre-channel[data-active=true]").click()

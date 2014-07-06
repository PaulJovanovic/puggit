streams = []
stream_order = []
stream_index = 0

shuffle = (a) ->
  for i in [a.length-1..1]
    j = Math.floor Math.random() * (i + 1)
    [a[i], a[j]] = [a[j], a[i]]
  a

changeChannel = ->
  stream_order = shuffle(Object.keys(streams))
  stream_name = stream_order[stream_index]
  $(".js-channel-status").html(streams[stream_name].status)
  $(".js-channel-display-name").html(streams[stream_name].display_name)
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

$(document).ready ->
  $(".js-theatre-channel").click ->
    $channel = $(@)
    $(".js-theatre-channel.active").removeClass("active")
    $channel.addClass("active")

    $.ajax(
      type: "GET"
      url: "/streams/search"
      data:
        query: $channel.data("name")
      dataType: "json"
    ).success (data)->
      streams = data
      stream_index = 0
      changeChannel()
      # setTimeout( ->
      #   player = $("#twitch_embed_player")[0]
      #   onlineChecker = setInterval( ->
      #     console.log(player.onlineStatus())
      #   , 60000)
      # , 60000)

  $(".js-theatre-skip").click ->
    if stream_index == stream_order.length - 1
      stream_index = 0
    else
      stream_index++
    changeChannel()

  $(".js-theatre-channel:first").click()

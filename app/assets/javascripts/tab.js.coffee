$(document).ready ->
  $(".js-tab").click ->
    $(@).toggleClass("active")
    $($(@).data("target")).toggleClass("hide")

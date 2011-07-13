$ = jQuery

$::serializeForm = ->
  result = {}
  $.each $(@).serializeArray(), (i, item) ->
    result[item.name] = item.value;
  result
$ = jQuery

$::serializeForm = ->
  result = {}
  for item in $(@).serializeArray()
    result[item.name] = item.value
  result
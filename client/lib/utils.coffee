@pluralize = (number, word) ->
  if number == 1
    word

  else
    "#{word}s"

@getFriendId = (friendship, current_user_id) ->
  emitter_id  = friendship.emitter
  receiver_id = friendship.receiver

  if emitter_id is current_user_id
    receiver_id
  else
    emitter_id

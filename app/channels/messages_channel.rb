class MessagesChannel < ApplicationCable::Channel

  def subscribed
    stream_from "chat_room_#{ chat_room.id }"
    PresenceTracker.redis.set "user_#{ current_user.id }", true
    PresenceTracker.track_user chat_room.id, current_user.id
    ActionCable.server.broadcast "chat_room_#{ chat_room.id }",
                                 user_id: current_user.id,
                                 online: true
  end

  def unsubscribe
    stop_all_streams
    PresenceTracker.redis.del "user_#{ current_user.id }"
    PresenceTracker.redis.untrack_user chat_room.id, current_user.id
    ActionCable.server.broadcast "chat_room_#{ chat_room.id }",
                                 user_id: current_user.id,
                                 online: false

  end

  def typing(data)
    ActionCable.server.broadcast "chat_room_#{ current_user.id }",
                                 user_id: current_user.id,
                                 typing: data['is_typing']
  end
end

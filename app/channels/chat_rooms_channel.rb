class ChatRoomsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "chat_rooms_user_#{ current_user.id }"
    PresenceTracker.redis.set "chat_rooms_user_#{ current_user.id }", true
    PresenceTracker.redis.track_user chat_room.id, current_user.id
  end

  def unsubscribe
    stop_all_streams
    PresenceTracker.redis.del "user_#{ current_user.id }"
    PresenceTracker.redis.untrack_user chat_room.id, current_user.id
  end
end

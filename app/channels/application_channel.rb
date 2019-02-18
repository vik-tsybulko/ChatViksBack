class ApplicationChannel < ApplicationCable::Channel

  def subscribed
    stream_from "application_channel"
    PresenceTracker.redis.set "user_#{ current_user.id }", true
    ActionCable.server.broadcast "application_channel",
                                 user_id: current_user.id,
                                 online: true
  end

  def unsubscribe
    stop_all_streams
    PresenceTracker.redis.del "user_#{ current_user.id }"
    ActionCable.server.broadcast "application_channel",
                                 user_id: current_user.id,
                                 online: false

  end
end

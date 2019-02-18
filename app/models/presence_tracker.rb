class PresenceTracker

  class << self
    def redis
      @redis ||= ::Redis.new(url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/#{ENV['REDIS_DB']}")
    end

    def track_user(chat_room_id, user_id)
      redis.sadd chat_room_id, user_id
    end

    def untrack_user(chat_room_id, user_id)
      redis.srem chat_room_id, user_id
    end

    def user_in_chat_room?(chat_room_id, user_id)
      redis.sismember chat_room_id, user_id
    end

    def chat_room_users(chat_room_id)
      redis.smembers chat_room_id
    end
  end
end

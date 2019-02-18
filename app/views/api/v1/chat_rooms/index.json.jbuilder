json.chat_rooms @chat_rooms.each do |chat_room|
  json.id                   chat_room.id
  json.title                chat_room.title
  json.avatar_url           chat_room.avatar_url
  json.avatar_preview_url   chat_room.avatar_preview_url
  json.user_id              chat_room.user_id
  json.chat_room_type       chat_room.chat_room_type
  json.created_at           chat_room.created_at
  json.updated_at           chat_room.updated_at
end

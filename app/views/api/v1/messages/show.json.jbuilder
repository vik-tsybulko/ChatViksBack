json.message do
  json.id                   @message.id
  json.message              @message.message
  json.chat_room_id         @message.chat_room_id
  json.user_id              @message.user_id
  json.ui_id                @message.ui_id
  json.read                 @message.read
  json.message_type         @message.message_type
end

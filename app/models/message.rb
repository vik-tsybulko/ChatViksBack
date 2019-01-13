class Message < ApplicationRecord

  enum message_type: {
      text: 0,
  }

  belongs_to :user
  belongs_to :chat_room

  validates_presence_of :message, :message_type, :ui_id
end

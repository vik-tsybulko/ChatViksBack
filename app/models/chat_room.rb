class ChatRoom < ApplicationRecord

  enum chat_room_type: {
      direct: 0,
      groups: 1
  }

  belongs_to :user
  has_and_belongs_to_many :users
  has_many :messages, dependent: :destroy

  has_attached_file :avatar,
                    styles: { preview: '500x500>' },
                    default_url: '/images/missing.png',
                    path: ":rails_root/public/system/chat_rooms/:id/avatars/:style/:filename",
                    url: "/system/chat_rooms/:id/avatars/:style/:filename"

  validates :title, presence: { message: "Title can't be blank" }
  validates :chat_room_type, presence: { message: "ChatRoom type can't be blank" }

  validates_attachment_size :avatar, less_than: 20.megabytes
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end

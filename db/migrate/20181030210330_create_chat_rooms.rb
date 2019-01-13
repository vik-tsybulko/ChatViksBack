class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.string :title
      t.attachment :avatar
      t.string :avatar_url
      t.string :avatar_preview_url
      t.references :user
      t.integer :chat_room_type
      t.timestamps
    end
  end
end

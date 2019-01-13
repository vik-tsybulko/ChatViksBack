class CreateJoinTableChatRoomsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms_users do |t|
      t.references :chat_room
      t.references :user
    end
  end
end

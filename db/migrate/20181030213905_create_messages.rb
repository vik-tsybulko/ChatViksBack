class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :message
      t.references :chat_room
      t.references :user
      t.string :ui_id
      t.boolean :read, default: false
      t.boolean :updated, default: false
      t.integer :message_type
      t.timestamp
    end
  end
end

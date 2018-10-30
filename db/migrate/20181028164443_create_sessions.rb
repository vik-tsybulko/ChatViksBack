class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :token
      t.references :user
      t.string :push_token
      t.string :device_type
      t.timestamps
    end
  end
end

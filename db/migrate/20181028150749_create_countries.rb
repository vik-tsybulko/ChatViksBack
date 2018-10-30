class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :phone_code
      t.string :alpha2_code
      t.string :alpha3_code
      t.string :numeric_code
      t.attachment :flag
    end
  end
end

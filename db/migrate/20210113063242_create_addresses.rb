class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      # テーブルの追加
      t.string :postal_code,         null: false, default: ""
      t.integer :prefecture_id,      null: false
      t.string :city,                null: false, default: ""
      t.string :address,             null: false, default: ""
      t.string :building,            default: ""
      t.string :phone_number,        null: false, default: ""
      t.references :purchase_list,   null: false, foreign_key: true 
      # //テーブルの追加
      t.timestamps
    end
  end
end

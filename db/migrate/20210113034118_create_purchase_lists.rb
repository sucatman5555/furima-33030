class CreatePurchaseLists < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_lists do |t|
      # テーブルの追加
      t.references :user,        null: false,  foreign_key: true
      t.references :item,        null: false,  foreign_key: true
      # //テーブルの追加
      t.timestamps
    end
  end
end

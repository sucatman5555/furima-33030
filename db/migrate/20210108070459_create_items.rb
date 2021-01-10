class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      # テーブルの追加
      t.string  :goods_name,                 null: false
      t.text    :goods_explanation,          null: false
      t.integer :goods_detail_category_id,   null: false
      t.integer :goods_detail_status_id,     null: false
      t.integer :delivery_method_id,         null: false
      t.integer :prefecture_id,              null: false
      t.integer :delivery_time_id,           null: false
      t.integer :selling_price,              null: false
      t.references :user,                    foreign_key: true
      # //テーブルの追加
      t.timestamps
    end
  end
end

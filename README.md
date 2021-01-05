# テーブル設計

## users テーブル

| Column            | Type   | Options                   |
| ----------------- | ------ | ------------------------- |
| email             | string | null: false, unique: true |
| encrypted_password| string | null: false               |
| nickname          | string | null: false               |
| last_name_kanji   | string | null: false               |
| first_name_kanji  | string | null: false               |
| last_name_kana    | string | null: false               |
| first_name_kana   | string | null: false               |
| user_birth_date   | date   | null: false               |


### Association

- has_many :items
- has_many :purchase_list



## items テーブル

| Column                  | Type                 | Options                        |
| ----------------------- | -------------------- | ------------------------------ |
| image                   | ActiveStorageで実装   |                                |
| goods_name              | string               | null: false                    |
| goods_explanation       | text                 | null: false                    |
| goods_detail_category_id| integer              | null: false                    |
| goods_detail_status_id  | integer              | null: false                    |
| delivery_method_id      | integer              | null: false                    |
| prefecture_id           | integer              | null: false                    |
| delivery_time           | string               | null: false                    |
| selling_price           | integer              | null: false                    |
| buyer_id                | references           | foreign_key: true              |
| user_id                 | references           | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_list



## purchase_list テーブル

| Column               | Type                 | Options                        |
| -------------------- | -------------------- | ------------------------------ |
| user_id              | references           | null: false, foreign_key: true |
| item_id              | references           | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :addresses



## addresses テーブル

| Column          | Type        | Options                        |
| --------------- | ----------- | ------------------------------ |
| postal_code     | string      | null: false                    |
| prefecture_id   | integer     | null: false                    |
| city            | string      | null: false                    |
| addresses       | string      | null: false                    |
| building        | string      |                                |
| phone_number    | string      | null: false                    |
| purchase_list_id| references  | null: false, foreign_key: true |

### Association

- belongs_to :purchase_list


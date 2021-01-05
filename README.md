# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| email           | string | null: false |
| password        | string | null: false |
| nickname        | string | null: false |
| last_name_kanji | string | null: false |
| first_name_kanji| string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| user_birth_date | date   | null: false |


### Association

- has_many :items
- has_many :purchase_list
- has_one :addresses


## items テーブル

| Column               | Type                 | Options                        |
| -------------------- | -------------------- | ------------------------------ |
| image                | ActiveStorageで実装   |                                |
| goods_name           | string               | null: false                    |
| goods_explanation    | text                 | null: false                    |
| goods_detail_category| string               | null: false                    |
| goods_detail_status  | string               | null: false                    |
| delivery_method      | string               | null: false                    |
| delivery_location    | string               | null: false                    |
| delivery_time        | string               | null: false                    |
| selling_price        | integer              | null: false                    |
| buyer_id             | references           | foreign_key: true              |
| user_id              | references           | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :purchase_list



## addresses テーブル

| Column         | Type        | Options                        |
| -------------- | ----------- | ------------------------------ |
| postal_code    | string      | null: false                    |
| prefecture     | integer     | null: false                    |
| city           | string      | null: false                    |
| addresses      | string      | null: false                    |
| building       | string      | null: false                    |
| phone_number   | string      | null: false                    |
| user_id        | references  | null: false, foreign_key: true |

### Association

- belongs_to :user


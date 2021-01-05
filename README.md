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
| user_birth_year | integer| null: false |
| user_birth_month| integer| null: false |
| user_birth_day  | integer| null: false |


### Association

- has_many :items


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
| user                 | references           | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase


## purchases テーブル

| Column         | Type        | Options                        |
| -------------- | ----------- | ------------------------------ |
| card_number    | string      | null: false                    |
| card_exp_month | integer     | null: false                    |
| card_exp_year  | integer     | null: false                    |
| card_cvc       | integer     | null: false                    |
| postal_code    | string      | null: false                    |
| prefecture     | string      | null: false                    |
| city           | string      | null: false                    |
| addresses      | string      | null: false                    |
| building       | string      | null: false                    |
| phone_number   | string      | null: false                    |
| buyer          | integer     | null: false                    |
| item           | references  | null: false, foreign_key: true |

### Association

- belongs_to :item


class Item < ApplicationRecord
  # バリデーションを設定
  with_options presence: true do
    validates :image
    validates :goods_name, length: { maximum: 40 }
    validates :goods_explanation, length: { maximum: 1000 }
    validates :goods_detail_category_id, numericality: { other_than: 1 }
    validates :goods_detail_status_id, numericality: { other_than: 1 }
    validates :delivery_method_id, numericality: { other_than: 1 }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :delivery_time_id, numericality: { other_than: 1 }
    # 半角数字かつ入力範囲が、¥300~¥9,999,999の間であること
    validates :selling_price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
  # //バリデーションを設定
  # アソシエーションを記述
  belongs_to :user

  # Active Storage
  has_one_attached :image

  has_one :purchase_list

  # カテゴリーの選択
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :goods_detail_category
  belongs_to :goods_detail_status
  belongs_to :delivery_method
  belongs_to :prefecture
  belongs_to :delivery_time
  # //アソシエーションを記述
end

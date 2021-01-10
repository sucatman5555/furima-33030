class Item < ApplicationRecord
  # バリデーションを設定
  with_options presence: true do
    validates :goods_name
    validates :goods_explanation
    validates :goods_detail_category_id, numericality: { other_than: 1 }
    validates :goods_detail_status_id, numericality: { other_than: 1 }
    validates :delivery_method_id, numericality: { other_than: 1 }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :delivery_time_id, numericality: { other_than: 1 }
    validates :selling_price
  end
  # //バリデーションを設定
  # アソシエーションを記述
  belongs_to :user

  # Active Storage
  has_one_attached :image

  # カテゴリーの選択
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :goods_detail_category
  belongs_to :goods_detail_status
  belongs_to :delivery_method
  belongs_to :prefecture
  belongs_to :delivery_time
  # //アソシエーションを記述
end

class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    # 「住所」の郵便番号に関するバリデーション
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, length: { maximum: 11 }, format: { with: /\A[0-9]+\z/, message: "半角数字で記入してください。" }
    # tokenが空では保存できないというバリデーションを追加
    validates :token
  end

  def save
    purchase_list = PurchaseList.create(user_id: user_id, item_id: item_id)
    # 上記のpurchase_list変数を用いて住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number,purchase_list_id: purchase_list.id)
  end
end
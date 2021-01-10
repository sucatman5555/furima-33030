FactoryBot.define do
  factory :item do
    goods_name               { Faker::Book.title }
    goods_explanation        { Faker::Book.publisher }
    goods_detail_category_id { rand(2..11) }
    goods_detail_status_id   { rand(2..7) }
    delivery_method_id       { rand(2..3) }
    prefecture_id            { rand(2..48) }
    delivery_time_id         { rand(2..4) }
    selling_price            { rand(300..9_999_999) }
    # user情報の紐付けが必要。
    association :user
    # テストコード用に画像をローカル環境で準備
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

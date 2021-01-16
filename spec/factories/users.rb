FactoryBot.define do
  factory :user do
    # 10.商品購入機能 #RV06
    nickname              { Faker::Name.initials }
    # purchase_address_specのテストにてitemもcreateするためメールの重複でエラーが
    # 発生してしまうため、ランダム生成に変更
    email                 { Faker::Internet.free_email }
    # //10.商品購入機能 #RV06
    password              { '12345a' }
    # 4.ユーザー管理機能 #RV07
    password_confirmation { '12345a' }
    # //4.ユーザー管理機能 #RV07
    last_name_kanji       { 'たらこ佐々木' }
    first_name_kanji      { '太郎' }
    last_name_kana        { 'タラコ' }
    first_name_kana       { 'タロウ' }
    user_birth_date       { '2006/05/04' }
  end
end

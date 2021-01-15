FactoryBot.define do
  factory :purchase_address do
    user_id              { rand(1..19) }
    item_id              { rand(20..50) }
    postal_code          { '236-0000' }
    prefecture_id        { rand(2..48) }
    city                 { '横浜市' }
    address              { '1-2-3-405' }
    building             { 'たらこビルディング' }
    phone_number         { '08012345678' }
    token                { 'tok_abcdefghijk00000000000000000' }
  end
end
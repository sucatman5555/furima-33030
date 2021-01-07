FactoryBot.define do
  factory :user do
    nickname              { 'たらこtarako1' }
    email                 { 'tarako@gmail.com' }
    password              { '12345a' }
    last_name_kanji       { 'たらこ佐々木' }
    first_name_kanji      { '太郎' }
    last_name_kana        { 'タラコ' }
    first_name_kana       { 'タロウ' }
    user_birth_date       { '2006/05/04' }
  end
end

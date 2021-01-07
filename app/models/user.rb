class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # バリデーションを設定
  # 英字と数字の両方を含めて設定
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は6文字以上、英字と数字の両方を含めてください' }
  validates :nickname, presence: true
  # ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'に全角文字（漢字・ひらがな・カタカナ）を使用してください' } do
    validates :last_name_kanji
    validates :first_name_kanji
  end
  # ユーザー本名のフリガナは、全角（カタカナ）での入力が必須
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'に全角文字（カタカナ）を使用してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end
  validates :user_birth_date, presence: true
  # //バリデーションを設定
end

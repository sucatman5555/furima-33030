class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # バリデーションを設定
  # 4.ユーザー管理機能 #RV05 （4.ユーザー管理機能 #RV01~02を削除、処理を書き直し）
  with_options presence: true do
    # 英字と数字の両方を含めて設定
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
                                   message: 'は6文字以上、英字と数字の両方を含めてください' }
    validates :nickname
    validates :user_birth_date
    # 半角文字も判定されてしまったため、バリデーション処理を修正
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/,
                           message: 'に全角文字（漢字・ひらがな・カタカナ）を使用してください' } do
      validates :last_name_kanji
      validates :first_name_kanji
    end
    # ユーザー本名のフリガナは、全角（カタカナ）での入力が必須
    with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/,
                                           message: 'に全角文字（カタカナ）を使用してください' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end
  # //4.ユーザー管理機能 #RV05
  # //バリデーションを設定
  # アソシエーションを記述
  has_many :items
  # //アソシエーションを記述
end

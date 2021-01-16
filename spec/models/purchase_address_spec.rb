require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @purchase_address = FactoryBot.build(:purchase_address)
  end

  describe '商品が購入可能な時（正常系）' do
    it '全ての情報を適切に入力すると、商品の購入ができること' do
      expect(@purchase_address).to be_valid
    end
    context '配送先入力-建物名' do
      it '空欄の場合でも購入処理が成功すること' do
        @purchase_address.building = nil
        expect(@purchase_address).to be_valid
      end
    end
  end
  describe '商品が購入不可能な時（異常系）' do
    # 10.商品購入機能 #RV05
    context 'referencesのNULLチェック' do
      it 'user_idが空の場合、購入処理に失敗すること' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空の場合、購入処理に失敗すること' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
    # //10.商品購入機能 #RV05
    context 'クレジットカード情報入力' do
      it 'トークンが空の場合、購入処理に失敗すること' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
    context '配送先入力-郵便番号' do
      it '空欄の場合、購入処理に失敗すること' do
        @purchase_address.postal_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'ハイフンが無い場合、購入処理に失敗すること' do
        @purchase_address.postal_code = '2360000'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
    end
    context '配送先入力-発送元の地域' do
      it '空欄の場合、購入処理に失敗すること' do
        @purchase_address.prefecture_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域を"--"に選択した場合、購入に失敗すること' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Prefecture must be other than 1')
      end
    end
    context '配送先入力-市区町村' do
      it '空欄の場合、購入処理に失敗すること' do
        @purchase_address.city = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
    end
    context '配送先入力-番地' do
      it '空欄の場合、購入処理に失敗すること' do
        @purchase_address.address = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end
    end
    context '配送先入力-電話番号' do
      it '空欄の場合、購入処理に失敗すること' do
        @purchase_address.phone_number = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'ハイフンを入れた場合、購入に失敗すること' do
        @purchase_address.phone_number = '080-1234'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number 半角数字で記入してください。')
      end
      it '電話番号が12桁以上の場合は購入に失敗すること' do
        @purchase_address.phone_number = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      # 10.商品購入機能 #RV04
      it '電話番号が英数混合の場合は購入に失敗すること' do
        @purchase_address.phone_number = '1234567890a'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number 半角数字で記入してください。')
      end
      # //10.商品購入機能 #RV04
    end
  end
end

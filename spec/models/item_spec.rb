require 'rails_helper'

RSpec.describe Item do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品が出品可能な時（正常系）' do
    it '必要な情報を適切に入力すると、商品の出品ができること' do
      expect(@item).to be_valid
    end
  end
  describe '商品が出品不可能な時（異常系）' do
    context '出品画像' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
    context '商品名' do
      it '商品名が必須であること' do
        @item.goods_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Goods name can't be blank")
      end
    end
    context '商品の説明' do
      it '商品の説明が必須であること' do
        @item.goods_explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Goods explanation can't be blank")
      end
    end
    context '商品の詳細-カテゴリー' do
      it 'カテゴリーが必須であること' do
        @item.goods_detail_category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Goods detail category can't be blank")
      end
      it 'カテゴリーを"--"に選択した時も登録に失敗すること' do
        @item.goods_detail_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Goods detail category must be other than 1')
      end
    end
    context '商品の詳細-商品の状態' do
      it '商品の状態が必須であること' do
        @item.goods_detail_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Goods detail status can't be blank")
      end
      it '商品の状態を"--"に選択した時も登録に失敗すること' do
        @item.goods_detail_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Goods detail status must be other than 1')
      end
    end
    context '配送について-配送料の負担' do
      it '配送料の負担が必須であること' do
        @item.delivery_method_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery method can't be blank")
      end
      it '配送料の負担を"--"に選択した時も登録に失敗すること' do
        @item.delivery_method_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery method must be other than 1')
      end
    end
    context '配送について-発送元の地域' do
      it '発送元の地域が必須であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域を"--"に選択した時も登録に失敗すること' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
    end
    context '配送について-発送までの日数' do
      it '発送までの日数が必須であること' do
        @item.delivery_time_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end
      it '発送までの日数を"--"に選択した時も登録に失敗すること' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery time must be other than 1')
      end
    end
    context '販売価格' do
      it '価格についての情報が必須であること' do
        @item.selling_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it '価格が¥300未満は登録に失敗すること' do
        @item.selling_price = 290
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be greater than or equal to 300')
      end
      it '価格が¥10,000,000以上は登録に失敗すること' do
        @item.selling_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be less than or equal to 9999999')
      end
      it '価格がマイナス時は登録に失敗すること' do
        @item.selling_price = -300
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be greater than or equal to 300')
      end
      it '販売価格は半角数字のみ保存可能であること' do
        @item.selling_price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is not a number')
      end
      # 5.商品出品機能 #Rv01
      it '英数混合では登録できないこと' do
        @item.selling_price = '300a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is not a number')
      end
      it '半角英語では登録できないこと' do
        @item.selling_price = 'abcd'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is not a number')
      end
      # //5.商品出品機能 #Rv01
    end
  end
end

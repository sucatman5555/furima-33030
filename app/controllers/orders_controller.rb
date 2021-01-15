class OrdersController < ApplicationController
  # ログアウト状態のユーザーは、ログインページへ遷移する
  before_action :authenticate_user!

  # @item = Item.find(params[:item_id])は繰り返し使われるのでset_itemで処理をまとめる
  before_action :set_item, only: [:index, :create, :pay_item, :move_to_index]

  # ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、
  # トップページに遷移する
  before_action :move_to_index, only: :index

  def index
    @purchase_address = PurchaseAddress.new # 「PurchaseAddress」に編集
  end

  def new
    # 購入完了画面
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params) # 「PurchaseAddress」に編集
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      # 購入完了画面へ遷移
      redirect_to action: :new
    else
      # エラーメッセージを保持するためにrenderで定義する
      # エラー後の再表示にて@itemが空になってしまうので事前にset_itemの呼び出しが必要
      render :index
    end
  end

  private

  # 全てのストロングパラメーターを1つに統合
  def purchase_address_params
    params.require(:purchase_address)
          .permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
    # 売れた商品の購入ページにはいけない
    redirect_to root_path if @item.purchase_list.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      # 商品の値段を出力するために事前にset_itemの呼び出しが必要
      amount: @item.selling_price, # 商品の値段
      card: purchase_address_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  # アクセス制御
  def move_to_index
    redirect_to root_path if current_user.id == @item.user_id
  end
  # //アクセス制御
end

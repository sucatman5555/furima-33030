class ItemsController < ApplicationController
  # 5.商品出品機能 #Rv02
  # ログアウト状態のユーザーは、商品出品ページへ遷移しようとすると、ログインページへ遷移する
  before_action :authenticate_user!, except: [:index, :show]
  # //5.商品出品機能 #Rv02

  # アクセス制御1-1（続きはprivate以降）
  # ログイン状態の出品者以外のユーザーは、
  # URLを直接入力して出品していない商品の商品情報編集ページへ遷移しようとすると、トップページに遷移する
  before_action :move_to_index, only: [:edit]

  # 8.商品情報編集機能 #RV01-01
  # @item = Item.find(params[:id])は繰り返し使われるのでset_itemで処理をまとめる
  before_action :set_item, only: [:show, :edit, :update]

  def index
    # N+1問題対策 Item.includes(:user)
    # 最新のものから並べる.order("created_at DESC")
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      # createアクションにデータ保存のための記述をし、保存されたときはルートパスに戻るような記述をした
      redirect_to root_path
    else
      # createアクションに、データが保存されなかったときは投稿ページへ戻るようrenderを用いて記述した
      render :new
    end
  end

  def show
    # 事前にset_itemを呼ぶ（8.商品情報編集機能 #RV01-02）
  end

  def edit
    # 事前にset_itemを呼ぶ（8.商品情報編集機能 #RV01-02）
  end

  def update
    # 事前にset_itemを呼ぶ（8.商品情報編集機能 #RV01-02）
    if @item.update(item_params)
      # 詳細画面に遷移
      redirect_to item_path(@item.id)
    else
      # 空欄があると編集画面にとどまる。
      render :edit
    end
  end

  private

  def item_params
    # itemsコントローラーのprivateメソッドにストロングパラメーターをセットし、
    # 特定の値のみを受け付けるようにした。且つ、user_idもmerge
    params.require(:item)
          .permit(:goods_name, :goods_explanation, :goods_detail_category_id, :goods_detail_status_id,
                  :delivery_method_id, :prefecture_id, :delivery_time_id, :selling_price, :image)
          .merge(user_id: current_user.id)
  end

  # アクセス制御1-2
  def move_to_index
    item = Item.find(params[:id])
    redirect_to action: :index unless user_signed_in? && current_user.id == item.user_id
  end
  # //アクセス制御1-2

  # 8.商品情報編集機能 #RV01-02
  def set_item
    @item = Item.find(params[:id])
  end
  # //8.商品情報編集機能 #RV01-02
end

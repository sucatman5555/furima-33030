class ItemsController < ApplicationController
  # 5.商品出品機能 #Rv02
  # ログアウト状態のユーザーは、商品出品ページへ遷移しようとすると、ログインページへ遷移する
  before_action :authenticate_user!, except: [:index, :show]
  # //5.商品出品機能 #Rv02

  def index
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
end

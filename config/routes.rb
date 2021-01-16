Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  # インデックスを設定
  root to: "items#index"
  # itemのルーティング設定
  # 9.商品削除機能 #RV02
  # 全てのアクションが揃ったのでonlyは削除
  resources :items do
    # 10.商品購入ページ作成
    resources :orders, only: [:index, :create]
  end
end

Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  # インデックスを設定
  root to: "items#index"
  # itemのルーティング設定
  resources :items, only: [:new, :create, :show, :edit, :update]
  
end

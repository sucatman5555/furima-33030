Rails.application.routes.draw do
  get 'items/index'
  # インデックスを設定
  root to: "items#index"
  
end

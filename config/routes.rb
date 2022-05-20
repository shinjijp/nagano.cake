Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...

  scope module: :public do
    root to: "homes#top"
    get 'homes/about'
    
    resources :customers,only: []
     get'customers' => 'customers#show'
     get'customers/edit' => 'customers#edit'
     get'customers/quit' => 'customers#quit'
     patch'customers/out' => 'customers#out'
     patch 'update/customers' => 'customers#update'
    resources :addresses
    resources :items
    resources :cart_items,only: [:index,:update,:create,:destroy] do
        collection do
          delete '/' => 'cart_items#all_destroy'
        end
      end
    resources :orders,only: [:new,:index,:show,:create] do
        collection do
          post 'confirm'
          get 'thanx'
        end
      end
  end
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

   namespace :admin do
     
    get 'homes/top'
    
    
    resources :admin
    resources :genres
    resources :items
    resources :customers
    resources :orders
    resources :order_details, only: [:update]
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

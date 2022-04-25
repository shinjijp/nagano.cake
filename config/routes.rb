Rails.application.routes.draw do
  
  devise_for :admins
   namespace :admin do
    root to: "homes#top"
    
    resources :genres
    resources :items
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

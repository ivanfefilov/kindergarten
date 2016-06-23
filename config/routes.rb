Rails.application.routes.draw do
  namespace :admin do
    resources :posts
    resources :users

    root to: "posts#index"
  end

  #devise_for :users
  
  root 'pages#home' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

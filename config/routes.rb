Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  
  root 'pages#home' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    get '' => 'dashboard#index'
    resources :posts, :users
  end  
end

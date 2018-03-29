Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  
  root 'pages#home' 
  get 'game' => 'pages#game'
  
  resources :posts do 
    member do 
      post 'comments', to: 'posts#create_comment', as: :create_comment
      delete 'comments/:comment_id', to: 'posts#destroy_comment', as: :destroy_comment 
    end
  end 
  
  resources :game_items, only: :index 
  
  namespace :admin do
    get '' => 'dashboard#index', as: 'root'
    resources :users, :categories, :game_items
    resources :posts do 
      get 'attachments', to: 'posts#attachments', as: :attachments
      post 'attachments', to: 'posts#attachment_create', as: :create_attachment
      delete 'attachments/:attachment_id', to: 'posts#attachment_destroy', as: :destroy_attachment
    end
  end  
end

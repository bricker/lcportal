LCPortal::Application.routes.draw do
  resources :statements, :writers, :admins
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :sessions, only: [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
    
  resource :profile, only: [:show, :edit, :update] do
    resources :statements, only: [:index, :show]
  end
  
  root to: 'statements#index'
end

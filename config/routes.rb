Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destory]
  resources :articles #as all the routes are exposed
  get 'signup', to: 'users#new'
  #post 'users', to: 'users#create'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
  # post 'follows/create', to: 'follows#create'
  resources :users do
    post 'follows/create', to: 'follows#create'
    delete 'follows/destroy', to: 'follows#destroy'
  end
end
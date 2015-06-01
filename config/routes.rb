Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # PAGE ROUTES
  get '/' => 'sessions#new', as: :root
  # USER ROUTES
  get 'users/new' => 'users#new', as: :new_user
  get 'users/:id' => 'users#show', as: :user
  get 'users/:id/logs' => 'users#log', as: :log
  post 'users/' => 'users#create'
  get 'users/:id/edit' => 'users#edit', as: :edit_user
  patch 'users/:id' => 'users#update'
  delete 'users/:id' => 'users#destroy'

  # TRACKING CODES ROUTES
  get 'trackingcodes/' => 'trackingcodes#index'
  get 'trackingcodes/expired' => 'trackingcodes#index', as: :expired_trackingcodes
  get 'trackingcodes/new' => 'trackingcodes#new', as: :new_trackingcode
  get 'trackingcodes/:id' => 'trackingcodes#show', as: :trackingcode
  post 'trackingcodes/' => 'trackingcodes#create', as: :add_trackingcode
  get 'trackingcodes/:id/edit' => 'trackingcodes#edit', as: :edit_trackingcode
  post 'trackingcodes/:id/' => 'trackingcodes#set_like', as: :like_trackingcode
  patch 'trackingcodes/:id' => 'trackingcodes#update'
  delete 'trackingcodes/:id' => 'trackingcodes#destroy'
  # API routes
  scope 'api', defaults: {format: :json} do
    post 'open_door/' => 'open_door#open', as: :open
  end
  get "/*path" => "sessions#new", format: false
end

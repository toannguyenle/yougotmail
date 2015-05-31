Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]
  # PAGE ROUTES
  get '/' => 'sessions#new', as: :root
  # USER ROUTES
  get 'users/new' => 'users#new', as: :new_user
  get 'users/:id' => 'users#show', as: :user
  post 'users/' => 'users#create'
  get 'users/:id/edit' => 'users#edit', as: :edit_user
  patch 'users/:id' => 'users#update'
  delete 'users/:id' => 'users#destroy'

  # TRACKING CODES ROUTES
  get 'trackingcodes/' => 'trackingcodes#index'
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
end

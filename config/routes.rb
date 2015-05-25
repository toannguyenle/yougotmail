Rails.application.routes.draw do
  root 'application#index'
  resources :users
  # API routes
  scope 'api', defaults: {format: :json} do
    resources :trackingcodes, only: [ :show, :index, :create, :update, :destroy]
  end
end

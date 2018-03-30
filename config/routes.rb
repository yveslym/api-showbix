Rails.application.routes.draw do
  devise_for :users
  namespace :v1, defaults: { format: :json }  do
  resource :sessions, only: [:create, :destroy,:show, :update]
post 'login/' => 'sessions#login'
    end
end

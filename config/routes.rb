Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts do
        resources :likes, only: [:create, :destroy]
      end
      resources :spots
      resources :profiles do
        resources :follows, only: [:create,:destroy,:index]
      end
      get '/spot/:place_id', to: 'spots#spot_detail'
      get '/user_id', to: 'users#user_id'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

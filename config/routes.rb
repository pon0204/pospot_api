Rails.application.routes.draw do
  root to: 'application#index'
  namespace :api do
    namespace :v1 do

      # get '/posts/:query/page/:page_id', to: 'posts#posts_infinity'
      get '/posts/:query/:user_id/page/:page_id', to: 'posts#profile_posts'
      get '/posts/New/:genre/:place/page/:page_id', to: 'posts#New_posts'
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

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/posts/:query/:user_id/page/:page_id', to: 'posts#profile_posts'
      get '/posts/new/:genre/:place/page/:page_id', to: 'posts#new_posts'
      get '/posts/follow/:user_id/:genre/:place/page/:page_id', to: 'posts#follow_posts'
      resources :posts, onky: %i[show create destroy] do
        resources :likes, only: %i[create destroy]
      end
      resources :spots, only: [:create]
      resources :profiles, only: %i[show update] do
        resources :follows, only: %i[create destroy index]
      end
      get '/spot/:place_id', to: 'spots#spot_detail'
      get '/user_id', to: 'users#user_id'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

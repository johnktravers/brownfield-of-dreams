Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: [:show, :index]
      resources :videos,    only: [:show]
    end
  end

  namespace :admin do
    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end

    get '/dashboard',                          to: 'dashboard#show'

    resources :videos,    only: [:edit, :update, :destroy]
    resources :tutorials, except: [:index, :show] do
      resources :videos,  only: [:create]
    end
  end

  root 'welcome#index'
  get  'tags/:tag',                            to: 'welcome#index', as: :tag
  get  '/register',                            to: 'users#new'
  get    '/login',                             to: 'sessions#new'
  post   '/login',                             to: 'sessions#create'
  delete '/logout',                            to: 'sessions#destroy'

  get '/dashboard',                            to: 'users#show'
  get '/activate',                             to: 'users#update'
  post '/add_friend/:friend_id',                           to: 'friendship#create'
  get '/about',                                to: 'about#show'
  get '/get_started',                          to: 'get_started#show'
  get '/invite',                               to: 'invite#new'
  post '/invite',                         to: 'invite#create'

  # Is this being used?
  # get '/video', to: 'video#show'

  resources :tutorials,   only: [:show, :index] do
    resources :videos,    only: [:show, :index]
  end

  resources :users,       only: [:new, :create, :update, :edit]
  resources :user_videos, only: [:create, :destroy]

  get '/auth/github',          as: 'connect_github'
  get '/auth/github/callback', to: 'github_connections#create'
end

Rails.application.routes.draw do
  resources :events
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  get '/areas', to: 'areas#index'
  get '/*', to: 'application#not_found'
end

Rails.application.routes.draw do
  resources :inscriptions
  resources :events
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  get '/areas', to: 'areas#index'
  get '/areas/metrics', to: 'areas#get_with_metrics'
  get '/areas/:username', to: 'areas#get_from_username'

  get '/events/area/:areaName', to: 'events#get_by_area'

  get '/*', to: 'application#not_found'
end

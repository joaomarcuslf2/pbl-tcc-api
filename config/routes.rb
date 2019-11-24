Rails.application.routes.draw do
  resources :inscriptions
  resources :events
  resources :reviews
  resources :users, param: :_username

  post '/auth/login', to: 'authentication#login'

  get '/areas', to: 'areas#index'
  get '/areas/metrics', to: 'areas#get_with_metrics'
  get '/areas/:username', to: 'areas#get_from_username'

  get '/requisites', to: 'requisites#index'
  post '/requisites', to: 'requisites#create'
  post '/requisites/:id/event/:event_id', to: 'requisites#create_requisite_event'

  get '/events/area/:areaName', to: 'events#get_by_area'
  post '/events/:id/audit-finish', to: 'events#audit_finish'

  get '/reviews/event/:event_id/user/:user_id', to: 'reviews#get_by_user_and_event'

  post '/users/:id/rate/:event_id', to: 'users#update_rate'

  put '/groups/:id', to: 'events#update_group'

  post '/recommendations', to: 'recommendations#create'
  get '/recommendations/:username', to: 'recommendations#get_by_author'

  get '/*', to: 'application#not_found'
end

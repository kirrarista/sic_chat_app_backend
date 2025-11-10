Rails.application.routes.draw do
  # Health
  get '/health', to: 'health#show'

  # Auth
  post '/auth/register', to: 'users#register'
  post '/auth/login', to: 'users#login'
  post '/auth/logout', to: 'users#logout'
  post '/auth/refresh', to: 'users#refresh'
  get '/auth/me', to: 'users#me'

  # Conversations
  get '/conversations', to: 'conversations#index'
  get '/conversations/:id', to: 'conversations#show'
  post '/conversations', to: 'conversations#create'
end
Rails.application.routes.draw do
  get '/health', to: 'health#show'

  post '/auth/register', to: 'users#register'
  post '/auth/login', to: 'users#login'
  post '/auth/logout', to: 'users#logout'
  post '/auth/refresh', to: 'users#refresh'
  get '/auth/me', to: 'users#me'
end
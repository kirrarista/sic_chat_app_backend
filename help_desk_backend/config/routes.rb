Rails.application.routes.draw do
  get '/health', to: 'health#show'

  post '/auth/register', to: 'users#register'
  post '/auth/login', to: 'users#login'
  post '/auth/logout', to: 'users#logout'
end
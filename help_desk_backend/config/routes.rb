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

  # Messages
  get '/conversations/:conversation_id/messages', to: 'messages#index'
  post '/messages', to: 'messages#create'
  put '/messages/:id/read', to: 'messages#mark_as_read'

  # Expert Operations
  get '/expert/queue', to: 'expert#queue'
  post '/expert/conversations/:conversation_id/claim', to: 'expert#claim'
  post '/expert/conversations/:conversation_id/unclaim', to: 'expert#unclaim'
  get '/expert/profile', to: 'expert#profile'
  put '/expert/profile', to: 'expert#update_profile'
  get '/expert/assignments/history', to: 'expert#assignments_history'

  # Update/Polling Endpoints
  get '/api/conversations/updates', to: 'api#conversations_updates'
  get '/api/messages/updates', to: 'api#messages_updates'
  get '/api/expert-queue/updates', to: 'api#expert_queue_updates'
end
Rails.application.routes.draw do
  resources :blog_entries
  root 'blog_entries#index'
end
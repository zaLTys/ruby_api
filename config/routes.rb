# frozen_string_literal: true

Rails.application.routes.draw do
  resources :wiki_posts
  namespace :wiki_posts do
    get 'example'
  end
  namespace :welcome do
    get 'index'
    get 'about'
    get 'archive'
  end

  namespace :api do
    namespace :v1 do
      resources :wiki_posts, only: [:index]
    end
  end

  get '/about', to: redirect('/welcome/about')
  root 'welcome#index'
end

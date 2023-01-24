# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'dashboard#index'

  devise_for :users

  concern :commentable do
    resources :comments, only: %i[show create destroy]
  end
  concern :likeable do
    resources :likes, only: %i[create destroy]
  end
  concern :reportable do
    resources :reports, only: %i[new create]
  end

  resources :users, only: :show
  resources :dashboard, only: :index
  resources :reports, only: :index
  resources :suggestions, only: :index

  shallow do
    resources :posts, concerns: %i[likeable reportable] do
      get :approve, on: :collection
      resources :suggestions, except: :index, concerns: :commentable
      resources :comments, only: %i[show create destroy], concerns: %i[likeable commentable reportable]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index show]
    end
  end
  
end

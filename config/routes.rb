# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  concern :commentable do
    resources :comments
  end
  concern :likeable do
    resources :likes
  end
  concern :reportable do
    resources :reports
  end

  resources :users, only: :show
  resources :dashboard, only: :index
  resources :posts, concerns: %i[likeable reportable] do
    resources :suggestions, concerns: :commentable
    resources :comments, concerns: %i[likeable commentable reportable]
  end
end

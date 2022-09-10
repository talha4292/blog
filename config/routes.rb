# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'dashboard#index'

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  concern :commentable do
    resources :comments do
      get :view, on: :member
    end
  end
  concern :likeable do
    resources :likes
  end
  concern :reportable do
    resources :reports do
      get :post_report, on: :member
      get :comment_report, on: :member
      post :report_status, on: :member
    end
  end

  resources :users, only: :show
  resources :dashboard, only: :index

  shallow do
    resources :posts, concerns: %i[likeable reportable] do
      get :approve, on: :collection
      post :approve_status, on: :member
      resources :suggestions, concerns: :commentable do
        get :list, on: :member
      end
      resources :comments, concerns: %i[likeable commentable reportable]
    end
  end
end

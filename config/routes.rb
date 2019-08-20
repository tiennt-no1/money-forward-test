# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users/:user_id', to: 'users#index'
  get '/users/dashboard', to: 'users#dashboard'
  root 'users#dashboard'
end

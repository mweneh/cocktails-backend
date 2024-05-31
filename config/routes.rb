# config/routes.rb
Rails.application.routes.draw do
  resources :cocktails, only: [:index, :show, :create, :update, :destroy]
end

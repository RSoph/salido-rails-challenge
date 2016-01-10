Rails.application.routes.draw do
  resources :wines
  root 'wine#index'
end

Rails.application.routes.draw do
  resources :wines
  root 'wines#index'

  namespace :api, :defaults => {:format => :json} do
    resources :wines
  end
end

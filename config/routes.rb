Rails.application.routes.draw do
  resources :eventos
  root 'home#index'
  get 'home/index'

  # Rotas Scaffold

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end

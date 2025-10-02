Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  
  # Rotas Scaffold
  resources :municipios
  resources :modalidades
  resources :eventos
  resources :tipos

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end

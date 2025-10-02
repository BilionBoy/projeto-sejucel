Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  
  # Rotas Scaffold
  resources :municipios
  resources :modalidades
  resources :eventos
  resources :tipos
  
  resources :acoes do
    collection do
      get :relatorios
    end
  end

  resources :participantes do
    member do
      get :qr_code
    end
    collection do
      get :qr_codes_pdf
      get :search   
    end
  end

  get 'scan_test', to: 'home#scan_test', as: :scan_test

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check
end

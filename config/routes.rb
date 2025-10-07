



Rails.application.routes.draw do
  get "/signin-oidc", to: "sauron_auth#callback"
  get '/auth/login', to: 'sauron_auth#login'
  get '/auth/callback', to: 'sauron_auth#callback'
  get '/auth/logout', to: 'sauron_auth#logout'


  root 'home#scan_test'
  get 'home/index'
  
  # Rotas Scaffold
  resources :municipios
  resources :modalidades
  resources :eventos
  resources :tipos
  resources :relatorios, only: [:index]

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

  # Relatório/Lote de QRCodes
  resources :pdfs, only: [] do
    collection do
      get :participantes_qrcodes
    end
  end

  get 'scan_test', to: 'home#scan_test', as: :scan_test

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check


end



Rails.application.routes.draw do
  root to: 'open_tok_sessions#index'
  resources :open_tok_sessions, except: [:edit, :update]
end

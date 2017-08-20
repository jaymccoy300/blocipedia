Rails.application.routes.draw do
  resources :downgrade, only: [:new, :create]

  resources :charges, only: [:new, :create]

  resources :wikis

  devise_for :users, controllers: { sessions: 'users/sessions' }

  get 'about' => 'welcome#about'

  root "welcome#index"
end

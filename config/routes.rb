Rails.application.routes.draw do
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  
  resources :portfolios, except: [:show]
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'

  resources :blogs

  root to: 'pages#home'
end

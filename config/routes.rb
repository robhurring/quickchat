Quickchat::Application.routes.draw do
  root :to => 'home#index'

  resources :rooms do
    member do
      post 'join'
    end
    resources :messages, only: [:create]
  end
end
Quickchat::Application.routes.draw do
  root :to => 'home#index'

  resources :rooms do
    resources :messages, :only => [:create]
  end
end
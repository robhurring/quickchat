Quickchat::Application.routes.draw do
  root :to => 'home#index'

  post '/pusher/hook' => 'pusher#hook'

  resources :rooms do
    member do
      post 'join'
      post 'leave'
    end
    resources :messages, only: [:create]
  end
end
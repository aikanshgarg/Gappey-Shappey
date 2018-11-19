Rails.application.routes.draw do
  
  # devise generated
  devise_for :users

  # scaffold generated
  resources :chatrooms  

  root 'chatrooms#index'
  
end

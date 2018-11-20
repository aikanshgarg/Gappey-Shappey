Rails.application.routes.draw do
  
  # devise generated
  devise_for :users

  # resources :chatrooms: scaffold generated
  # rest of the nested routes were made by us
  resources :chatrooms do
  	resource :chatroom_users
  end

  root 'chatrooms#index'
  
end

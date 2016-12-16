Rails.application.routes.draw do
  resources :children
  resources :absent_children
  resources :class_rooms
  resources :codes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

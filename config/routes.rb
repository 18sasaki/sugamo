Rails.application.routes.draw do
  root :to => 'absent_children#index'
  resources :children
  resources :absent_children
  resources :class_rooms
  resources :codes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

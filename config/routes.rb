Rails.application.routes.draw do
  get  'dairies/', to: 'dairies#index'
  post 'dairies/bulk_update'

  get 'child_histories/', to: 'child_histories#index'
  get 'child_histories/show'

  get 'class_room_histories/index'
  get  'manages/', to: 'manages#index'
  post 'manages/dairy_create'
  post 'manages/cr_history_create'

  root :to => 'absent_children#index'
  resources :children
  resources :absent_children
  resources :class_rooms
  resources :codes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

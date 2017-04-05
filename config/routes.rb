Rails.application.routes.draw do
  resources :dairy_child_bus_stops
  resources :bus_courses
  resources :buses
  get  'class_room_attendances/confirm'
  post 'class_room_attendances/create'

  get  'dairies/', to: 'dairies#index'
  post 'dairies/bulk_update'

  get 'child_histories/', to: 'child_histories#index'
  get 'child_histories/show'


  get 'class_room_histories/index'
  get  'manages/', to: 'manages#index'
  post 'manages/dairy_create'
  post 'manages/cr_history_create'

  # root :to => 'absent_children#index'
  root to: 'dairies#show'

  get 'children/bus_stops_select_main', to: 'children#bus_stops_select_main'
  get 'children/bus_stops_select_sub', to: 'children#bus_stops_select_sub'
  get 'children/class_room_children', to: 'children#class_room_children'
  resources :children

  resources :absent_children
  resources :class_rooms
  resources :codes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:date', to: 'dairies#show'
end

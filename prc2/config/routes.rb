Rails.application.routes.draw do
  resources :ubicaciones
  get 'servicios/index'
  root 'servicios#index'



  get 'servicios/comunas_map'
  #get 'json1' => 'servicios#comunas_map', :defaults => { :format => 'json' }




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

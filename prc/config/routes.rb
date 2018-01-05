Rails.application.routes.draw do
  get 'servicios/index'
  get 'servicios/index2'
  get 'servicios/index3'
  get 'servicios/index4'
  
  root 'servicios#index'
  get 'json2' => 'servicios#index2', :defaults => { :format => 'json' }
  get 'json3' => 'servicios#index3', :defaults => { :format => 'json' }
  get 'json4' => 'servicios#index4', :defaults => { :format => 'json' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

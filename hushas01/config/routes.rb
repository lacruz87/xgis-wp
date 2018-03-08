Rails.application.routes.draw do
  
  resources :prop_casapi_info2s
  resources :objetivos
  resources :direcciones
  resources :comunas
  resources :regiones
  resources :direcs  
  resources :prop_casapi_infos
  resources :props
     
  #Generamos la Api
  get 'api/new'
  get 'api/new_pi' => 'api#new', :fuente=>:PortalInmobiliario
  post 'api/new_pi' => 'api#new', :fuente=>:PortalInmobiliario
  get 'api/delete_all' => 'api#deleteAll'
  get 'api/buscarcodigo' => 'api#findCodigoPi' #, :fuente=>:PortalInmobiliario
  get 'api/procesarCasasLC' => 'api#procesarCasasLC' #, :fuente=>:PortalInmobiliario
  
  #fin metodos de la api

  #Generamos los servicios de la Página
  root 'servicios#index'
  get 'servicios/buscador' => 'servicios#buscador'
  get 'servicios/nueva_busqueda' => 'servicios#nueva_busqueda'
  get 'servicios/objetivo' => 'servicios#index3'
  get 'servicios/download' => 'servicios#download'
  get 'servicios/prueba' => 'servicios#prueba'
  
  #fin de los servicios
  
  #otros links

  get 'servicios/index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

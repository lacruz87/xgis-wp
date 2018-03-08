Rails.application.routes.draw do
  root 'servicios#index'
  
  get 'servicios/index'

  get 'servicios/prueba'

  get 'servicios/comunas_map'

  get 'servicios/comuna_request'

  get 'servicios/comuna_response'

  get 'servicios/predios_map'

  get 'servicios/predios_request'

  get 'servicios/predios_response'

  get 'servicios/prcs_map'

  get 'servicios/prc_request'

  get 'servicios/prc_response'

  get 'servicios/general_request'

  get 'servicios/general_response'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :props
  get 'main/index'

  get 'main/site_request'

  get 'main/site_response'
  root 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

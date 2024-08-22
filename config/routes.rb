Rails.application.routes.draw do
  resources :kinds
  resources :contacts do
    resource :kind, only: [:show]
    resource :phones, only: [:show, :update, :create, :destroy]
    resource :address, only: [:show, :update, :create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

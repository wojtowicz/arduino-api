Rails.application.routes.draw do
  resources :devices, except: [:edit, :new, :create], param: :uuid
  namespace :pollution do
    resources :measurements, only: :index
  end
end

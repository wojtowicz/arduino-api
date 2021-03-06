Rails.application.routes.draw do
  resources :devices, except: [:edit, :new, :create], param: :uuid do
    scope module: 'devices' do
      namespace :pollution do
        resources :measurements, only: :index
      end
    end
  end
end

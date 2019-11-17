Rails.application.routes.draw do
  namespace :pollution do
    resources :measurements, only: :index
  end
end

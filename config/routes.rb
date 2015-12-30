Rails.application.routes.draw do
  devise_for :users, path: ''

  resources :stationeries
  resources :users, except: [:new, :create, :destroy] do
    member do
      get  :stationeries_history
      get  :borrow_stationery
      post :borrow_stationery
      put  :clear_stationery
    end
  end

  root 'stationeries#index'
end

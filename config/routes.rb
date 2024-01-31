Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :members, only: [:create] do
    get :doctors, on: :collection
    get :patients, on: :collection
  end

  resources :opportunities, only: [:index, :create, :update, :destroy] do
    patch :move_to_next_stage, on: :member
    post :search, on: :collection
  end
end

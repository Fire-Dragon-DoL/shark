Rails.application.routes.draw do
  scope "/v1", format: :json do
    resources :users, only: [:create]
    resources :sessions, only: [:create]
  end
end

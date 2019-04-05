Rails.application.routes.draw do
  resources :members, only: [:index, :show, :new, :create]
  get "/pages/:page" => "pages#show"
  root "pages#show", page: :home
end

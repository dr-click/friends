Rails.application.routes.draw do
  resources :members, only: [:index, :show, :new, :create] do
    resources :friendships, only: [:create]
    member do
      get :set_current
    end
  end

  get "/pages/:page" => "pages#show"
  root "pages#show", page: :home
end

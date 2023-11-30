Rails.application.routes.draw do
  root to: "rooms#index"

  get "account", to: "users#account_show"
  get "profile", to: "users#profile_show"
  get "profile/edit", to: "users#profile_edit"
  post "profile/edit", to: "users#profile_update"

  get "rooms/own", to: "rooms#own"

  get "reservations", to: "reservations#index"

  get "search", to: "searches#search"
  get "search_by_area", to: "searches#search_by_area"

  resources :rooms
  resources :reservations do
    collection do
      post 'confirm'
    end
  end
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

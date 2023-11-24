Rails.application.routes.draw do
  root to: "users#index"

  get "account", to: "users#account_show"

  get "profile", to: "users#profile_show"
  get "profile/edit", to: "users#profile_edit"
  post "profile/edit", to: "users#profile_update"

  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

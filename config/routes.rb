Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show]
  resources :line_items, only: [:create, :destroy]

  root to: redirect("/books")
end

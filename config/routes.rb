Golf::Application.routes.draw do
  root :to => "home#index"
  get :info, to: "home#info"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end

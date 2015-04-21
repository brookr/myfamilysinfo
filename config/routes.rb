Myfamilysinfo::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  get ':users/:id/', :to => "user#show"

  resource :user, { controller: :users, only: :show } do
    resources :kids, only: [:new, :create] do
      resources :reminders, only: [:new, :create] do
      end
    end
  end
  resources :kids, only: [:destroy]
  resources :reminders, only: [:destroy, :update]

  namespace :api do
    namespace :v1 do
      resources :kids, except:[:edit, :new] do
        resources :events, except: [:show, :edit, :new]
      end
      resource :users, only: [:create, :update]
      resource :sessions, only: [:create]
    end
  end
end

Myfamilysinfo::Application.routes.draw do
  get 'angular/index'

  root :to => 'angular#index'
  get 'app', to: 'angular#app'

  resource :user, { controller: :users, only: :show } do
    resources :kids, only: [:new, :create] do
      resources :reminders, only: [:new, :create] do
      end
    end
  end
  resources :kids, only: [:destroy]
  resources :reminders, only: [:destroy, :update]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :kids, except:[:edit, :new] do
        resources :events, except: [:show, :edit, :new]
      end
      resources :users, only: [:create, :update]
      resources :sessions, only: [:create]
    end
  end
end

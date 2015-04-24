Myfamilysinfo::Application.routes.draw do
  get 'angular/index'

  root :to => 'angular#index'
  get 'app', to: 'angular#app'

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

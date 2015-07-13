Rails.application.routes.draw do

  resource :settings, only: [ :edit, :update ]

  resources :environments, except: [ :new, :create ] do
    resources :instances
    resources :hosts
  end

  resources :components do
    resources :instances, except: [ :new, :create ]
    get 'toggle',  on: :member
  end

  resources :instances, except: [ :new, :create ] do
    post 'run',   on: :member
    post 'stop',  on: :member
  end

  resources :releases

  resources :projects do
    resources :releases
    resources :environments
    resources :components
    get 'toggle', on: :member
  end
  
  resources :hosts, except: [ :new, :create ] do
    get 'toggle',  on: :member
  end

  resources :registries do
    get 'refresh', on: :collection
    get 'partial', on: :collection

    get 'toggle',  on: :collection
    get 'toggle',  on: :member
  end

  resources :welcome, only: [] do
    get 'index', on: :collection
    get 'help',  on: :collection
  end

  root 'welcome#index'

end

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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

HerokuDashboard::Application.routes.draw do

  root 'dashboard#index'

  get "dashboard/index"
  put "dashboard/async" => "dashboard#async_update", as: 'async'
  get "dynos/info" => 'app_groups#dynos_status'
  get "addons/info" => 'app_groups#addons_status'
  get "group/:tag" => 'app_groups#show', as: :group
  scope :settings do
    post "apps/multiple" => 'heroku_apps#multiple_create', as: 'multiple_create'
    put "apps/multiple" => 'heroku_apps#multiple_update', as: 'multiple_update'
    resources :apps, controller: 'heroku_apps', as: 'heroku_apps', except: [:create] do
      member do
        put :update_api
      end
    end
  end


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

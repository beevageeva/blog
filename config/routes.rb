Blog::Application.routes.draw do
  resources :comments

  resources :posts

  resources :categories

  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

	 match 'changeActiveUsers/:userid'  => 'users#changeActive'
	 match 'login_as/:userid'  => 'users#loginAs'
	 match 'change_password/:id'  => 'users#chPw'
	 match 'upload_category_image/:category_id'  => 'categories#upload_image'
	 match 'delete_category_image/:category_id'  => 'categories#delete_image'
	 match 'list_by_category/:category_id'  => 'posts#listByCategory'
	 match 'new_by_category/:category_id'  => 'posts#newPost'
  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'posts#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id))(.:format)'


	 match 'login'  => 'users#login', :as => :login
	 match 'logout'  => 'users#logout', :as => :logout
	 match 'register'  => 'users#new', :as => :register
	 match 'lost_password'  => 'users#get_lost_password', :as => :lost_password




end

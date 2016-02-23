Rails.application.routes.draw do

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # The main job of the routes:
  # You map a request to A controller with an action
  get "/hello/" => "welcome#index"
  get "/about" => "welcome#about"

  # providing the :as option will give us a route helper method. It will
  # override the default one if any.
  # Please note that route helpers only loop at the `path` portion of the route
  # and not the HTTP Verb.
  # Helper methods must be unique
  get "/hello/:name" => "welcome#greet", as: :greet

  get  "/subscribe" => "subscribe#index"
  post "/subscribe" => "subscribe#create"

  # get "/ideas/new" => "ideas#new", as: :new_idea
  # post "/ideas" => "ideas#create", as: :ideas
  # get "/ideas/:id" => "ideas#show", as: :idea
  # get "/ideas/:id/edit" => "ideas#edit", as: :edit_idea
  # patch "/ideas/:id" => "ideas#update"
  # delete "/ideas/:id" => "ideas#destroy"
  #
  # # the PATH for this URL (index action) is the same as the PATH for the
  # # create action (with POST) so we can just use the one we defined for the
  # # create which is `ideas_path`
  # get "/ideas" => "ideas#index"
  resources :ideas do
    get   :search,    on: :collection
    patch :mark_done, on: :member
    post  :approve

    # get "members", on: :collection

    # By defining `resources :comments` nested inside `resources :ideas`
    # Rails will defined all the comments routes prepended with
    # `/ideas/:idea_id`. This enables us to have the idea_id handy
    # so we can create the comment associated with a idea with `idea_id`
    resources :comments, only: [:create, :destroy]

    resources :likes, only: [:create, :destroy]

    resources :members, only: [:create, :destroy]

    resources :votes, only: [:create, :update, :destroy]
  end

  # scope :ideas do
  #   resources :members, only: [:index]
  # end

  resources :members, only: [:index]

  # We do this to avoid triple nesting comments under `resources :comments` within
  # the `resources :ideas` as it will be very cumbersome to generate routes
  # and use forms. We don't need another set of `comments` routes in here so
  # pass the `only: []` option to it.
  resources :comments, only: [] do
    resources :comments, only: [:create, :destroy]
  end


  resources :users, only: [:create, :new]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # resources :comments

  # post "/ideas/:idea_id/comment" => "comments#create"

  # setting the home page of our application to be the idea listings page
  root "ideas#index"

  # This will map any GET request with path "/hello" to WelcomeController and
  # index action within that controller

  # Every user request in Rails must be handled by A controller and an action

  # get is a method from Rails routes to help us respond to GET request
  # it takes a Hash as a paramter:
  # get({"/hello" => "welcome#index"})

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

GossipLogin::Application.routes.draw do

  
  get "sintetic_login/choose_role"
  post "sintetic_login/choose_role"

  match '/get_stats/:id', to: 'coments_and_stats#get_stats', via: :get
  match '/get_coments/:id', to: 'coments_and_stats#get_coments', via: :get

  match 'auth/:provider/callback' => 'sessions#create_signed'
  match 'auth/failure' => 'sessions#failure'
    
  match '/get_chestionar/:id_curs', to: 'evaluarea_cursurilor#get_chestionar', via: [:post,:get]
  match '/post_chestionar/:id_curs', to: 'evaluarea_cursurilor#post_chestionar', via: :post

  root to: 'sessions#new', via: [:get]
  root to: 'sessions#create', via: [:post]

  match '/token_sign_in', to: 'sessions#new', as: "sign_in"
  match '/token_sign_out', to: 'sessions#abort_token_session', as: "token_sign_out"
  match '/sign_out', to: 'sessions#abort_signed_session', as: "sign_out"

  match '/pdf_gen', to: 'static_pages#home'

  match '/homepage' , to: 'sessions#redirect_to_asigned', as: "homepage"
  match '/verificare', to: 'evaluarea_cursurilor#verificare'
  match '/admin/(:spec/(:anul))', to: 'pagina_administrator#pagAdmin', as: "homepage_admin"
  match '/params', to: 'pagina_administrator#setare_resetare', as: 'update_params'
  match '/profesor/(:spec/(:anul))', to: 'pagina_profesor#pagProfesor', as: "homepage_profesor"
  match '/student/(:spec/(:anul))', to: 'pagina_student#pagStudent', as: "homepage_student"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

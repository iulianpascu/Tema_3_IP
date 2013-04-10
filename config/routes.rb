GossipLogin::Application.routes.draw do

  get 'pagina_setare/create'
  post 'pagina_setare/create'

  #get "evaluarea_cursurilor/verificare"

  #get "student/listare"
  #
  #get "student/completare"
  #
  #get "administrare/listare"
  #
  #get "administrare/adaugare"
  #
  #get "administrare/generare"
  #
  #get "autentificare/autentifica"
  #
  #get "static_pages/home"

  match 'auth/:provider/callback' => 'sessions#create_signed'
  match 'auth/failure' => 'sessions#failure'



  resources :sessions, only: [:new, :create, :destroy]

  root to: 'sessions#new'

 	match '/homepage' , to: 'sessions#redirect_to_asigned', as: "homepage"

  match '/token_sign_in', to: 'sessions#new', as: "sign_in"

  match '/token_sign_out', to: 'sessions#abort_token_session', as: "token_sign_out"

  match '/pdf_gen', to: 'static_pages#home'

  match '/verificare', to: 'evaluarea_cursurilor#verificare'

  match '/admin/:spec', to: 'pagina_administrator#pagAdmin', as: "homepage_admin"

  match '/profesor', to: 'pagina_profesor#pagProfesor', as: "homepage_profesor"

  match '/student', to: 'pagina_student#pagStudent', as: "homepage_student"


 #match '/signup', to: 'users#new'


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

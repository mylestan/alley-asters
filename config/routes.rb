Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  scope :dumpster, module: :admin do
    get "", to: "dashboard#index", as: :admin_root
    get "login", to: "sessions#new", as: :admin_login
    post "login", to: "sessions#create", as: nil
    delete "logout", to: "sessions#destroy", as: :admin_logout
    get "plants", to: "plants#index", as: :admin_plants
    post "plants", to: "plants#create"
    get "plants/:id/edit", to: "plants#edit", as: :edit_admin_plant
    patch "plants/:id", to: "plants#update", as: :admin_plant
    delete "plants/:id", to: "plants#destroy"
    get "plots", to: "plots#index", as: :admin_plots
    get "plots/new", to: "plots#new", as: :new_admin_plot
    post "plots", to: "plots#create", as: :create_admin_plot
    get "plots/:id/edit", to: "plots#edit", as: :edit_admin_plot
    patch "plots/:id", to: "plots#update", as: :admin_plot
    delete "plots/:id", to: "plots#destroy"
    post "plots/:plot_id/photos", to: "photos#create", as: :admin_plot_photos
    patch "photos/:id", to: "photos#update", as: :admin_photo
    delete "photos/:id", to: "photos#destroy"
    get "tasks", to: "tasks#index", as: :admin_tasks
    get "tasks/new", to: "tasks#new", as: :new_admin_task
    post "tasks", to: "tasks#create", as: :create_admin_task
    get "tasks/:id/edit", to: "tasks#edit", as: :edit_admin_task
    patch "tasks/:id", to: "tasks#update", as: :admin_task
    delete "tasks/:id", to: "tasks#destroy"
    get "tools", to: "tools#index", as: :admin_tools
    post "tools", to: "tools#create"
    delete "tools/:id", to: "tools#destroy", as: :admin_tool
    get "inventory", to: "inventory#index", as: :admin_inventory
    post "inventory", to: "inventory#create"
    get "inventory/:id/edit", to: "inventory#edit", as: :edit_admin_inventory_item
    patch "inventory/:id", to: "inventory#update", as: :admin_inventory_item
    delete "inventory/:id", to: "inventory#destroy"
  end

  get "signup", to: "registrations#new", as: :signup
  post "signup", to: "registrations#create"
  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout
  get "profile", to: "profiles#edit", as: :profile
  patch "profile", to: "profiles#update"
  get "tasks", to: "user_tasks#index", as: :user_tasks

  get "plots/:slug", to: "plots#show", as: :plot
  get "old", to: "pages#old"
  root "pages#home"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/", to: "home#index", as: :root
  post "/", to: "home#authorize", as: :signin
  get "/info", to: "home#info", as: :info
  delete "/signout", to: "home#destroy", as: :signout
  get "/orders/pending", to: "orders#pending", as: :pending_orders
  get "admins/menus", to: "admins#manage_menus", as: :manage_menus
  get "admins/managebillers", to: "billers#manage_billers", as: :manage_billers
  patch "users/makeasbiller", to: "users#make_as_biller", as: :make_as_biller
  patch "admins/change_menu_name", to: "menus#change_name", as: :change_menu_name
  patch "admins/change_menuitem_status", to: "menu_items#change_status", as: :change_menuitem_status
  get "admins/stats", to: "admins#stats", as: :stats
  resources :users
  resources :menus
  resources :orders
  resources :admins
  resources :billers
  resources :menu_items
  post "/orders/cart", to: "orders#cart", as: :cart
  delete "/orders/cart/remove", to: "orders#remove_from_cart", as: :remove_cart_item
  post "user/rolechange", to: "admins#role_change", as: :user_role_change
  post "user/roleback", to: "admins#role_back", as: :original_role
  patch "order/deliver", to: "admins#mark_as_delivered", as: :deliver_order
end

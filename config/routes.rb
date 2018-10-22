Rails.application.routes.draw do

  get '/validity', to: 'users#valid'
  resources :roles
  resource :shops do
    get '/shops_by_name', to: 'shops#shops_by_name'
    get '/single', to: 'shops#show'
    get '/favorites', to: 'shops#favorites'
    get '/products', to: 'shops#show_products'
    patch '/single', to: 'shops#update'
    get '/latest_products', to: 'shops#latest_products'
    get '/products/show_listings', to: 'shops#show_listings'
  end

  get '/carts', to: 'carts#show'
  post '/carts/product', to: 'carts#add_item'
  delete '/carts/product', to: 'carts#remove_item'

  resource :products do
    post '/image', to: 'products#add_image'
    get '/products_by_name', to: 'products#products_by_name'
    get '/latest', to: 'products#get_favorites'
    get '/favorites', to: 'products#show_favorites'
    post '/favorite', to: 'products#create_favorites'
    delete '/favorite', to: 'products#delete_favorites'
    get '/popular', to: 'products#show_popular'
  end

  resource :users do
    post '/token', to: 'users#token'
    patch '/role', to: 'roles#set_role'
    get '/role', to: 'roles#show_role'
    get '/shops', to: 'shops#my_shops'
  end

  post '/favorite', to: 'favorites#favorite'
  get '/favorites', to: 'favorites#favorites'
  delete '/favorite', to: 'favorites#un_favorite'

  post '/omniauth/:provider', to: 'omniauth_login#omniauth_token'

end

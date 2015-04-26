Rails.application.routes.draw do
  root 'articles#index'

  resources :articles do
  	member do
  		post 'like'
  	end
  end

  resources :users, except: [:new]
  get '/register', to: 'users#new'
  
  resources :tags

  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'

end

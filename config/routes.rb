Rails.application.routes.draw do
  
  get '/houses/own', to: 'houses#own'
  resources :houses

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

end

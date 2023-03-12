Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do 
    devise_for :users, cotrollers: { 
                sessions: 'sessions',
                registrations: 'registrations'},
                path_names: { sign_in: :login,
                              sing_out: :logout }
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

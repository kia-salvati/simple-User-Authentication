Rails.application.routes.draw do
  scope :api do 
    devise_for :users, controllers: { 
                sessions: 'users/sessions',
                registrations: 'users/registrations'},
                path: '',
                path_names: {
                              sign_in: 'login',
                              sign_out: 'logout',
                              registration: 'signup'
                             }
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

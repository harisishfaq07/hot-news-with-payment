Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :registrations => 'registrations'  }
  devise_scope :user do
  get "free_signup" , to: "registrations#free_signup"
  post "create_free_signup" , to: "registrations#create_free_signup"
  end
   resources :news
  root "home#homepage"
  get "landpage" , to: "home#landpage"
end

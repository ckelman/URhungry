UrHungry::Application.routes.draw do
  resources :reviews

  devise_for :users
  resources :foods

  resources :places

  resources :ratings, only: :update

  resources :welcome do
    collection do
      get :about
      get :contact
      get :search
    end
end
  
  root 'welcome#index'
  
  get '/new_food_place/:my_place' => 'foods#new', as: 'new_food_place'
  
  get '/new_food_review/:my_food' => 'reviews#new', as: 'new_food_review'

end

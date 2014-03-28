UrHungry::Application.routes.draw do
  resources :reviews

  devise_for :users
  resources :foods

  resources :places

  resources :welcome do
    collection do
      get :about
      get :contact
    end
end
  
  root 'welcome#index'
  
  
end

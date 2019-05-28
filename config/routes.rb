Rails.application.routes.draw do
  resources :bookmarks
  resources :searches
  resources :feedbacks
  resources :products do
  	collection do
  		get :search
  	end
  end
  resources :users do
    collection do
      get :get_feed
    end
  end
  resources :sub_categories
  resources :categories
  resources :tests
end

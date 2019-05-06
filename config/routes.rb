Rails.application.routes.draw do
  resources :articles
  resources :scraping_urls do
    collection do
      get :calculate_all_pbox
    end
    get :calculate_pbox
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

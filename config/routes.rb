Rails.application.routes.draw do
  resources :articles
  resources :scraping_urls
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

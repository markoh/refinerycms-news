Refinery::Application.routes.draw do
  resources :news, :as => :news_items, :controller => :news_items

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :news, :as => :news_items, :controller => :news_items
  end
end
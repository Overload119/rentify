Rentify::Application.routes.draw do
  root :to => "property#index"
  get "/search" => "property#search"
  get "/show/:id" => "property#show", :as => "property"
end

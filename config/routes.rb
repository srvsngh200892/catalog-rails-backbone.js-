Products::Application.routes.draw do
  root :to => "main#index"
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :products
    end
  end
end

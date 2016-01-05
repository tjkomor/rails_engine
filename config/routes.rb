Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers
      resources :invoice_items
      resources :invoices
      resources :items
      resources :merchants
      resources :transactions
    end
  end
end

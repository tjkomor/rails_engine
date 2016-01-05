Rails.application.routes.draw do
  resources :customers
  resources :invoice_items
  resources :invoices
  resources :items
  resources :merchants
  resources :transactions
end

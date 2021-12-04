Rails.application.routes.draw do
  resources :borrowers
  get "/borrowers/:id/loans" => "borrowers#loans"

  resources :investors
  get "/investors/:id/loans" => "investors#loans"
  get "/investors/:id/investor_groups" => "investors#investor_groups"

  resources :investor_groups
  get "/investor_groups/:id/investors" => "investor_groups#investors"
  post "/investor_groups/:id/investor" => "investor_groups#add_investor"
  delete "/investor_groups/:id/investor" => "investor_groups#remove_investor"

  resources :loans
  get "/loans/:id/investor" => "loans#investor"
  get "/loans/:id/borrower" => "loans#borrower"
  get "/loans/:id/marketplaces" => "loans#marketplaces"

  resources :marketplaces
  get "/marketplaces/:id/investor_groups" => "marketplaces#investor_groups"
  get "/marketplaces/:id/investors" => "marketplaces#investors"
end

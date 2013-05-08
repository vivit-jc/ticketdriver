Ticketdriver::Application.routes.draw do
  resources :tickets do
  end
  resources :comments do
  end
  root :to => "tickets#index"
  
end

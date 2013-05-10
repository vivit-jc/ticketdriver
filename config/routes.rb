Ticketdriver::Application.routes.draw do
  resources :projects, :expect => [:show] do
    resources :tickets do
    end
  end
  resources :comments do
  end
  root :to => "projects#index"
  
end

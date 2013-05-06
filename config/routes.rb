Z::Application.routes.draw do
  resources :triggers
  resources :txns do
    collection do
      post 'deleteall'
    end
  end
  resources :members do
    member do
      post "reset"
      post "burn"
    end
  end
  

end

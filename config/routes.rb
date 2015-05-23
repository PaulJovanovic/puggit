Rails.application.routes.draw do
  devise_for :users
  resources :user_channels do
    member do
      post :activate
    end
  end
  resource :theatre
  resource :channels do
    collection do
      get :search
    end
  end
  resource :streams do
    collection do
      get :search
      get :status
    end
  end
  root to: "theatres#show"
end

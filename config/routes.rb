Rails.application.routes.draw do
  devise_for :users
  resource :theatre
  resource :channels do
    collection do
      get :search
    end
  end
  resource :streams do
    collection do
      get :search
    end
  end
  root to: "theatres#show"
end

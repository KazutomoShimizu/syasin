Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get '/', to: 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :feeds do
    collection do
      post :confirm
    end
  end
end

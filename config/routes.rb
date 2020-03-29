Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy
end

Rails.application.routes.draw do
  resources :users, except: :index
  resource :session, only: [:create, :new, :destroy]
  resources :subs
  resources :posts, except: :index do
    resources :comments, only: :new
  end

  resources :comments, only: [:create, :edit, :update, :destroy, :show]
end

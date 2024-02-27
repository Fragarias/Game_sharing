Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :end_users, skip: [:passwords], controllers: { #sign_up sign_inのみ
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'end_users/information/edit' => 'end_users#edit'
    get 'end_users/quit'
    patch 'end_users/update'
    patch 'end_users/withdraw'
    resources :end_users, only: [:index, :show]
    resources :communities, only: [:index, :show] do
      resource :game_bookmarks, only: [:create, :destroy]
    end
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    resources :relationships, only: [:create, :index, :destroy]
    resources :notifications, only: [:index]
  end

  devise_for :admins, skip: [:registrations, :passwords], controllers: { #sign_inのみ
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :communities, only: [:new, :create, :index, :show, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:create, :index, :update, :destroy]
  end

end

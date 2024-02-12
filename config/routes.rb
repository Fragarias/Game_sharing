Rails.application.routes.draw do
  namespace :admin do
    get 'tags/index'
  end
  namespace :admin do
    get 'posts/show'
  end
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
  end
  namespace :admin do
    get 'communities/new'
    get 'communities/index'
    get 'communities/show'
    get 'communities/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'notifications/index'
  end
  namespace :public do
    get 'relationships/index'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'communities/index'
    get 'communities/show'
  end
  namespace :public do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
    get 'end_users/quit'
  end
  namespace :public do
    get 'homes/top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :end_users, skip: [:passwords], controllers: { #sign_up sign_inのみ
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: { #sign_inのみ
    sessions: "admin/sessions"
  }

end

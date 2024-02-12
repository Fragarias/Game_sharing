Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :end_users, skip: [:passwords], controllers: { #sign_up sign_inのみ
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: { #sign_inのみ
    sessions: "admin/sessions"
  }

end

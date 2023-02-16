Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end

  scope module: :public do
    root 'homes#top'
    resources :photos, only: [:index, :edit, :show, :new, :create, :update, :destroy] do
      resource :favorites, only: [:create, :destroy] #「s」をなくすことで、URLに/:idが含まれなくなり,1人のユーザーが1つの投稿にいいねを押すことが出来るのが１回のみなので、URLにparams[:id]を使わなくても良いので「ｓ」を無くした書き方
      resources :photo_comments, only: [:create, :destroy]
    end
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrawal'
    resources :customers, only: [:show, :index, :edit, :update] do
      resource :follows, only: [:create, :destroy]
      get 'followings' => 'follows#followings', as: 'followings'
      get 'followers' => 'follows#followers', as: 'followers'
      member do
        get :favorites
      end
    end
    get 'search' => 'searches#search'
  end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :categories, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :photos, only: [:index, :edit, :show, :update, :destroy] 
end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

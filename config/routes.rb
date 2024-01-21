Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
        sessions: "admin/sessions",
      }
  devise_for :stores, skip: [:passwords], controllers: {
      registrations: "store/registrations",
      sessions: "store/sessions"
    }
  devise_for :customers, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: "public/sessions"
    }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # guest login
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
  # 店舗側
  namespace :store do
    resources :stores do
      resources :items
    end
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :customers, only: [:index, :show, :edit, :update]
    get "search" => "searches#search"
  end
  # 管理者側
  namespace :admin do
    resources :stores, only: [:index, :show, :create]
    get '/', to: 'admin/home#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    get "search" => "searches#search"
  end
  # 顧客側
  scope module: :public do
    resources :stores, only: [:index] do
      resource :favorite, only: [:create, :destroy]
      resources :items, only: [:index, :show]
    end
    resources :customers, only: [:update] do
      member do
        get :favorites
      end
    end
      get '/customers/withdraw_confirm' => 'customers#withdraw_confirm', as: "withdraw_confirm"
      patch '/customers/withdraw' => 'customers#withdraw'
      get '/customers/mypage' => 'customers#show', as: "mypage"
      get '/customers/confirmation' => 'customers#confirmation', as: 'confirmation'
      get 'customers/infomation/edit' => 'customers#edit', as: "infomation"
    resources :cart_items, except: [:show, :edit, :new]
      delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    get 'orders/thanks' => 'orders#thanks'
    post 'orders/confirm' => 'orders#confirm', as: "confirm"
    get 'orders/possible' => 'orders#possible', as: "possible"
    get 'orders/production' => 'orders#production', as: "prodction"
    get 'orders/review' => 'orders#review', as: "review"
    resources :orders, except: [:edit, :update, :destroy]
    root to: 'homes#top'
    get "search" => "searches#search"
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, defaults: { format: :json }, except: [:edit, :new] do
    collection do
        post 'sign_in'
    end
    resources :posts, only: [:index, :create, :destroy] do
      collection do
        get 'feed'
      end
    end
    resources :follows, only: [:create, :destroy] do
        collection do
            get 'followers'
            get 'followings'
        end
    end
  end

end

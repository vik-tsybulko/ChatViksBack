Rails.application.routes.draw do
  root to: 'pages#index'

  mount TryApi::Engine => '/developers'
  mount ActionCable.server => '/cable'

  scope '(:locale)' do
    namespace :api do
      namespace :v1 do
        post :login, to: 'sessions#create'
        delete :logout, to: 'sessions#destroy'
        resources :users, only: [:create, :show] do
          collection do
            get :profile, to: 'users#profile'
            put :update, path: :update_profile
          end
        end
        resources :chat_rooms
      end
    end
  end
end

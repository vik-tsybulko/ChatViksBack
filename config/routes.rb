Rails.application.routes.draw do
  root to: 'pages#index'

  mount TryApi::Engine => '/developers'

  scope '(:locale)' do
    namespace :api do
      namespace :v1 do
        resources :chats
      end
    end
  end
end

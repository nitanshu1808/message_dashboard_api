Rails.application.routes.draw do
  # api version one for users
  namespace 'api' do

    namespace 'v1' do

      resources :users, defaults: { format: :json }

    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # api version one for users
  namespace 'api' do
    namespace 'v1' do
      resources :users, except: [:update], defaults: { format: :json }
    end
  end
end

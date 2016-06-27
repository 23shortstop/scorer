Rails.application.routes.draw do
  scope path: '/api' do
    api_version(:module => "Api::V1", :header => {
      :name => "Accept", :value => "application/vnd.templateapp.v1+json" }, :default => true) do
      resources :users, only: [:show, :create] do
        get :current, on: :collection
      end

      resources :sessions, only: [:create, :destroy], path: "users/sessions"
    end
  end
end
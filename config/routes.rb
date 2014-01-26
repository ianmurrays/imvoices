Imvoices::Application.routes.draw do
  resources :users

  scope :api, defaults: { format: 'json' } do
    scope :v1 do
      resources :users do
        post :authenticate, on: :collection
      end
    end
  end

  # Matches any route other than the ones on the top
  get '(*any)' => 'application#angular'

  root 'application#angular'
end

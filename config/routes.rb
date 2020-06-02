Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do 
    get '/', to: 'api#index'
  end 
end

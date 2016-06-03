Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/bitbucket/descriptor', to: 'bitbucket#descriptor', format: :json 
  post '/installed', to: 'lifecycle#installed'
  post '/uninstalled', to: 'lifecycle#uninstalled'
  get '/stars', to: 'stars#show'
  put '/stars', to: 'stars#save'
  get '/all-stars', to: 'all_stars#show'
  
end

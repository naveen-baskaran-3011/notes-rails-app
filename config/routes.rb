Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  put 'notes', to: 'notes#create'
  get 'notes', to: 'notes#index'
  get 'notes/:id', to: 'notes#show'
  put 'notes/:id', to: 'notes#update'
  delete 'notes/:id', to: 'notes#destroy'

end

Rottenpotatoes::Application.routes.draw do
  
  get 'movies/same_director/:id', :to => 'movies#same_director', :as => 'same_director'
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end

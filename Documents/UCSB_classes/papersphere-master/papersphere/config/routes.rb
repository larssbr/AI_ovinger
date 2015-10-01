Papersphere::Application.routes.draw do
  
  resources :reading_list_shares

  get 'remote_library/search'
  post 'remote_library/search'

  resources :group_members

  resources :reading_list_papers, :except => [ :edit, :update ]
  match '/remove_paper_from_list' => 'reading_list_papers#remove_paper_from_list', :as => 'remove_paper_from_list'

  resources :ratings, :only => [ :create, :update ]
  resources :comments, :only => [ :create ]
  get '/comments' => 'comments#load_more_comments', :as => 'load_comments'

  resources :groups, :except => [ :new, :edit ]

  resources :papers

  resources :reading_lists, :except => [ :new, :edit ]

  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root to: 'reading_lists#index'

end

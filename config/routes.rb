Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  resources :conversations do
		resources :messages
	end

  resources :friendships
  resources :users
  resources :pages
  get '/conversations/index'  => 'conversations#index' 
  get '/send_request', to: 'pages#send_request', as: 'send_request'
  get '/search', to: 'pages#search', as: 'search'
  get '/approve_request', to: 'friendships#approve_request', as: 'approve_request'
  get '/unfriend_request', to: 'friendships#unfriend_request', as: 'unfriend_request'
  get '/conversations', to: 'friendships#chat', as: 'chat'

  get '/', to: 'pages#home', as: 'dashboard'

  root 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

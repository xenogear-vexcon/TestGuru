Rails.application.routes.draw do

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout },
             controllers: { sessions: 'sessions' }


  root 'tests#index'

  resources :badges, only: :index

  resources :tests, only: :index do
    post :start, on: :member
  end

  resources :test_passages, only: %i[show update] do
    get :result, on: :member
    post :gist, on: :member
    get :badge, on: :member
  end

  namespace :admin do
    root 'tests#index'
    resources :gists, only: :index
    resources :tests do
      patch :update_inline, on: :member
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    resources :badges
  end

  get '/contact', to: 'application#contact'
  post '/contact', to: 'application#create_feedback'

end

Rails.application.routes.draw do
  resources :experience_emotions

  resources :experience_categories

  resources :categories

  resources :votes

  resources :comments

  resources :experiences

  root to: 'experiences#index'
end

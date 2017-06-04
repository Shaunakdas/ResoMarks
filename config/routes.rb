Rails.application.routes.draw do
  resources :entity_scores
  resources :attempt_answers
  resources :answers
  resources :questions
  resources :exam_attempts
  resources :exam_sets
  resources :exams
  resources :difficulty_levels
  resources :auth_tokens
  resources :user_phone_numbers
  resources :users
  resources :subtopics
  resources :topics
  resources :chapters
  resources :streams
  resources :subjects
  resources :standards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

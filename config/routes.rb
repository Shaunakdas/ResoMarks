Rails.application.routes.draw do
  resources :user_question_scores
  resources :user_exam_difficulty_breakups
  resources :exam_difficulty_breakups
  resources :user_group_reference_scores
  resources :exam_reference_scores do 
      collection do
        get   :get_ref_score
      end
    end
  namespace :api, :defaults => {:format => :json} do  
    resources :reference_scores  do 
      collection do
        get   :get_ref_score
        get   :get_only_score
      end
    end
    resources :analytics do 
      collection do
        get   :get_analytics
        get   :get_exam_list
      end
    end
  end
  resources :products
  resources :weak_entities
  resources :spis
  resources :target_exams
  resources :score_names
  resources :user_entity_scores
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

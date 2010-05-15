ActionController::Routing::Routes.draw do |map|

  map.resources :questions do |question|
    question.resources :answers do |answer|
      answer.resources :comments
    end
  end

  
  map.root :controller => "questions"
  
  map.resource :user_session
  
  map.vote_up 'vote_up', :controller => 'questions', :action => 'vote_up'
  map.vote_down 'vote_down', :controller => 'questions', :action => 'vote_down'
  
  map.set_correct_answer 'set_correct_answer', :controller => 'questions', :action => 'set_correct_answer'
  map.favorite_question 'favorite_question', :controller => 'questions', :action => 'favorite_question'
  
  map.sign_out 'sign_out', :controller => 'user_sessions', :action => 'destroy'
  map.sign_up 'sign_up', :controller => 'users', :action => 'new'
  map.sign_in 'sign_in', :controller => 'user_sessions', :action => 'new'
  
  
  
  
  map.resources :users do |user|
    user.resources :messages do |message|
      message.resources :replies
    end
  end
  
  map.resources :followships
  
  #map.connect '/:name', :controller => 'users', :action => 'index'
  
end

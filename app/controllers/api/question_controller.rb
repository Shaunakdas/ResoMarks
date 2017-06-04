class Api::QuestionController < ApiController
	skip_before_action :authenticate_user!
  	protect_from_forgery :except => :test_attempt
end

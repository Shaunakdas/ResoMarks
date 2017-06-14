class Api::AnalyticsController < ApiController
	def get_analytics
		response ={}
	    attempted =  0
	    # number = 16437970
	    number = params[:rollno]
	    #exam_id =1
	    exam_id = params[:exam_id]
	    exam = Exam.where(:id => exam_id).first
	    user=User.where(:roll_number => number).first
	    exam_attempt =ExamAttempt.where(:exam_id => exam_id, :user=> user).first
	    entity_score = EntityScore.where(:entity_type =>'Standard', :exam_attempt => exam_attempt).first if exam_attempt
		user_ref_score = UserGroupReferenceScore.where(:entity_type =>'Standard', :entity_score => entity_score).first if exam_attempt && entity_score
		
		# Criteria for weak topic:-
		# any question of difficulty type medium and easy left blank or incorrect
		subject_weak_topic_list||={}
		Subject.all.each do |subject|
			Question.where(:subject => subject).each do |question|
				if question.difficulty_level.name == "Medium" || question.difficulty_level.name == "Easy"
					puts "subject"+subject.name+"question seq "+question.sequence_number.to_s
					UserQuestionScore.where(:question => question, :exam_attempt => exam_attempt).each do |score|
						puts "Score Value"+score.value.to_s
						if score.blank || score.incorrect
							subject_weak_topic_list[question.subject.name]||=[]
							subject_weak_topic_list[question.subject.name] << question.topic.name
							subject_weak_topic_list[question.subject.name] = subject_weak_topic_list[question.subject.name].uniq
						end
					end
				end
			end
		end
		# subjectwise_reference_scores
		user_ref_score_hash||={}
		user_ref_score_hash["maximum_score"]||={} 
		user_ref_score_hash["average_score"]||={}
		user_ref_score_hash["highest_score"]||={}
		user_ref_score_hash["user_score"]||={}
		user_ref_score_hash["user_percentile"]||={}
		user_ref_score_hash["user_percentage"]||={}
		Subject.all.each do |subject|
			exam_ref_score = ExamReferenceScore.where(:exam => exam, :entity_type => 'Subject', :entity_id => subject.id).first
			user_ref_score_hash["maximum_score"][subject.name]=exam_ref_score.maximum
			user_ref_score_hash["average_score"][subject.name]=exam_ref_score.average
			user_ref_score_hash["highest_score"][subject.name]=exam_ref_score.highest
			entity_subj_score = EntityScore.where(:entity_type =>'Subject', :exam_attempt => exam_attempt).first
			user_ref_score = UserGroupReferenceScore.where(:entity_score => entity_subj_score, :entity_type => 'Subject', :entity_id => subject.id).first
			user_ref_score_hash["maximum_score"][subject.name]=entity_subj_score.value
			user_ref_score_hash["average_score"][subject.name]=user_ref_score.average
			user_ref_score_hash["highest_score"][subject.name]=user_ref_score.highest
		end


		diff_level||={}
		DifficultyLevel.all.each do |level|
			diff_level['name']||=[]; diff_level['name'] << level.name
			UserExamDifficultyBreakup.where(:exam_attempt => exam_attempt, :difficulty_level => level).each do |breakup|
				diff_level['user']||=[]; diff_level['user'] << breakup.correct
			end
			ExamDifficultyBreakup.where(:exam => exam, :difficulty_level => level).each do |breakup|
				diff_level['exam']||=[]; diff_level['exam'] << breakup.count
			end
		end
		diff_level['name'] << "Total"
		diff_level['user'] << diff_level['user'].inject(:+)
		diff_level['exam'] << diff_level['exam'].inject(:+)


	    # All India Rank
	    response["air"]=user_ref_score.rank
	    # SPI
	    response["spi"]=0
	    # Subjectwise Weak Topics List
	    response["weak_topic_list"]=subject_weak_topic_list
	    # Subjectwise user reference scores and exam reference scores
	    response["subjectwise_reference_scores"]||={}
	    # Difficultywise breakup
	    response["difficulty_breakup"]=diff_level
	    # Subjectwise topic effective score
	    response["subjectwise_effective_score"]||={}
	    # UserQuestionScore for this exam
	    response["user_question_score"]||={}
	    render json: response.to_json, status: 200
	end
end

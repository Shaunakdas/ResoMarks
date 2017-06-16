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
		# Relative user score
		relative_user_score||={}
		relative_user_score["name"]=[]
		relative_user_score["user_score"]=[]
		relative_user_score["average_score"]=[]
		max_s = "Maximum Score";avg_s = "Average Score";high_s = "Highest Score"; your_s ="Your Score"; your_per = "Your Percentage"; your_perile= "Your Percentile"
		# subjectwise_reference_scores
		user_ref_score_hash||={}
		user_ref_score_hash[max_s]||={}   ;user_ref_score_hash[max_s]["Total"]=0
		user_ref_score_hash[avg_s]||={}   ;user_ref_score_hash[avg_s]["Total"]=0
		user_ref_score_hash[high_s]||={}   ;user_ref_score_hash[high_s]["Total"]=0
		user_ref_score_hash[your_s]||={}   ;user_ref_score_hash[your_s]["Total"]=0
		user_ref_score_hash[your_per]||={}   ;user_ref_score_hash[your_per]["Total"]=0
		user_ref_score_hash[your_perile]||={}   ;user_ref_score_hash[your_perile]["Total"]=0
		standard = Standard.first
		Subject.all.each do |subject|
			exam_ref_score = ExamReferenceScore.where(:exam => exam, :entity_type => 'Subject', :entity_id => subject.id).first
			user_ref_score_hash[max_s][subject.name]=exam_ref_score.maximum.round(2)
			user_ref_score_hash[max_s]["Total"] += exam_ref_score.maximum.round(2)

			user_ref_score_hash[avg_s][subject.name]=exam_ref_score.average.round(2)
			user_ref_score_hash[avg_s]["Total"] += exam_ref_score.average.round(2)

			user_ref_score_hash[high_s][subject.name]=sprintf('%.2f', exam_ref_score.highest)
			user_ref_score_hash[high_s]["Total"] += sprintf('%.2f', exam_ref_score.highest).to_d

			entity_subj_score = EntityScore.where(:entity_type =>'Subject', :exam_attempt => exam_attempt, :entity_id => subject.id).first
			user_subj_score = UserGroupReferenceScore.where(:entity_score => entity_subj_score, :entity_type => 'Subject', :entity_id => subject.id).first
			user_std_score = UserGroupReferenceScore.where(:entity_score => entity_subj_score, :entity_type => 'Standard').first
			user_ref_score_hash[your_s][subject.name]=entity_subj_score.value.round(2)
			user_ref_score_hash[your_s]["Total"] += entity_subj_score.value.round(2)

			user_ref_score_hash[your_perile][subject.name]=user_subj_score.percentile.round(2) if user_subj_score
			
			user_ref_score_hash[your_perile]["Total"] = user_std_score.percentile if user_std_score

			user_ref_score_hash[your_per][subject.name]=(entity_subj_score.value.to_f*100/exam_ref_score.maximum).round(2)
			user_ref_score_hash[your_per]["Total"] +=(entity_subj_score.value.to_f*100/exam_ref_score.maximum).round(2)
			
			relative_user_score["name"]<< subject.name
			relative_user_score["user_score"] << entity_subj_score.value.round(2)
			relative_user_score["average_score"] << exam_ref_score.average.round(2)
		end
		user_ref_score_hash[your_per]["Total"] = (user_ref_score_hash[your_s]["Total"].to_f*100/user_ref_score_hash[max_s]["Total"].to_f).round(2)
		

		relative_user_score["name"] << "Total"
		relative_user_score["user_score"] << relative_user_score["user_score"].inject(:+)
		relative_user_score["average_score"] << relative_user_score["average_score"].inject(:+)

		# Difficultywise breakup Table
		diff_level_table||={}
		diff_level_table['Total']=[0,0]
		DifficultyLevel.all.each do |level|
			diff_level_table[level.name]||=[]
			UserExamDifficultyBreakup.where(:exam_attempt => exam_attempt, :difficulty_level => level).each do |breakup|
				 diff_level_table[level.name] << breakup.correct
				 diff_level_table['Total'][0] += breakup.correct
			end
			ExamDifficultyBreakup.where(:exam => exam, :difficulty_level => level).each do |breakup|
				diff_level_table[level.name] << breakup.count
				 diff_level_table['Total'][0] += breakup.count
			end
		end

		# Difficultywise breakup
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

		# UserQuestionScore for this exam
		user_ques_score_list =[]

		Question.where(:exam => exam).each do |ques|
			user_ques_score={}
			user_ques_score['seq']=ques.sequence_number
			user_ques_score['subject']=ques.subject.name
			user_ques_score['topic']=ques.topic.name
			user_ques_score['difficulty']=ques.difficulty_level.name
			user_score = UserQuestionScore.where(:exam_attempt => exam_attempt,:question => ques).first
			if user_score.correct
				user_ques_score['answer']=0
			elsif user_score.incorrect
				user_ques_score['answer']=1
			else
				user_ques_score['answer']=2
			end
			user_ques_score_list << user_ques_score
		end
		# Subjectwise topic effective score
		subj_eff_score||={}
		Subject.all.each do |subject|
			subj_eff_score[subject.name]||={}
			Topic.where(:subject => subject).each do |topic|
				EntityScore.where(:exam_attempt => exam_attempt, :entity_type=> 'Topic', :entity_id => topic.id).each do |user_topic_score|
					# topic = Topic.where(:id => user_topic_score.entity_id).first
					subj_eff_score[subject.name][topic.name]=user_topic_score.effective_score
				end
			end
		end
		#Old Exam relation present
		old_exam_attempt=false;old_index=0
		user_attempt_array=ExamAttempt.where(:user => user).all
		user_attempt_array.each_with_index do |attempt_item,index|
			if exam_attempt.id==attempt_item.id  && index > 0
				p index
				old_exam_attempt=true
				old_index = index -1
			end
		end

		weak_score = ScoreName.where(:display_text => 'Weak').first

		old_weak_to_normal||={}
		old_normal_to_weak||={}
		if old_exam_attempt

			old_attempt = user_attempt_array[old_index]
			puts "Old attempt id"+old_attempt.id.to_s
			# old_attempt_array.each do |old_attempt|
				EntityScore.where(:score_name => weak_score, :exam_attempt => old_attempt, :entity_type=>'Topic').each do |old_entity_score|
					p old_entity_score.entity_id
					EntityScore.where( :exam_attempt => exam_attempt, :entity_type=>'Topic', :entity_id => old_entity_score.entity_id).each do |entity_score|
						topic = Topic.where(:id=> old_entity_score.entity_id).first
						p topic.name
						old_weak_to_normal[topic.name]||={}
						# old_weak_to_normal[topic.name]['old_score'] = old_entity_score.value
						old_weak_to_normal[topic.name]['old_score_name'] = old_entity_score.score_name.display_text
						old_weak_to_normal[topic.name]['new_score_name'] = entity_score.score_name.display_text
					end
				end
			# end

			# old_attempt_array.each do |old_attempt|
				EntityScore.where(:score_name => weak_score, :exam_attempt => exam_attempt, :entity_type=>'Topic').each do |entity_score|
					EntityScore.where( :exam_attempt => old_attempt, :entity_type=>'Topic', :entity_id => entity_score.entity_id).each do |old_entity_score|
						if (old_entity_score.score_name!= weak_score)
							topic = Topic.where(:id=> old_entity_score.entity_id).first
							old_normal_to_weak[topic.name]||={}
							# old_normal_to_weak[topic.name]['old_score'] = old_entity_score.value
							old_normal_to_weak[topic.name]['old_score_name'] = old_entity_score.score_name.display_text
							old_normal_to_weak[topic.name]['new_score_name'] = entity_score.score_name.display_text
						end
					end
				end
			# end
		end

	    # All India Rank
	    response["air"]=user_ref_score.rank
	    # SPI
	    response["spi"]=getSpi(user_ref_score_hash[your_s]["Total"]).round(2)
	    # Subjectwise Weak Topics List
	    response["weak_topic_list"]=subject_weak_topic_list
	    # Relative user score
	    response["relative_user_score"]=relative_user_score
	    # Subjectwise user reference scores and exam reference scores
	    response["subjectwise_reference_scores"]=user_ref_score_hash
	    # Difficultywise breakup
	    response["difficulty_breakup"]=diff_level
	    # Difficultywise breakup table
	    response["difficulty_breakup_table"]=diff_level_table
	    # Subjectwise topic effective score
	    response["subjectwise_effective_score"]=subj_eff_score
	    #Old Exam relation present
	    response["old_exam_present"]=old_exam_attempt
	    response["old_weak_to_normal"] = old_weak_to_normal
	    response["old_normal_to_weak"] = old_normal_to_weak
	    # UserQuestionScore for this exam
	    response["user_question_score"] = user_ques_score_list
	    render json: response.to_json, status: 200
	end
	def get_exam_list
		response ={}
	    attempted =  0
	    # number = 16437970
	    number = params[:rollno]
	    user=User.where(:roll_number => number).first
	    ExamAttempt.where(:user=> user).each do |exam_attempt|
	    	entity_score = EntityScore.where(:entity_type =>'Standard', :exam_attempt => exam_attempt).first if exam_attempt
			user_ref_score = UserGroupReferenceScore.where(:entity_type =>'Standard', :entity_score => entity_score).first if exam_attempt && entity_score
			response[exam_attempt.exam.name]||={}
			response[exam_attempt.exam.name]['exam_id']=exam_attempt.exam.id
			response[exam_attempt.exam.name]['rank']=user_ref_score.rank
			
		end
		render json: response.to_json, status: 200
	end
	def getSpi(score)
	  spi = 0
	  if score.between?(0,90)
	    spi = score.to_f*0.5/94
	  elsif score.between?(90,150)
	    spi = ((score-94).to_f*0.5/56)+0.5
	  elsif score > 150
	    spi = 1
	  elsif score < 0
	    spi = 0
	  end
	  return spi
	end
end

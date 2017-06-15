#Calculating ExamDifficultyBreakup
Exam.all.each do |exam|
    DifficultyLevel.all.each do |level|
        Question.where(:exam => exam, :difficulty_level => level).each do |question|
            difficulty_breakup = ExamDifficultyBreakup.where(:exam =>exam, :difficulty_level => level).first
            if difficulty_breakup
                existing_breakup = difficulty_breakup.count
                puts "Updating difficulty breakup with existing value "+existing_breakup.to_s+" of type "+level.name
                difficulty_breakup.update_column(:count, existing_breakup+1)  
            else
                puts "Adding difficulty breakup with existing value "+existing_breakup.to_s+" of type "+level.name
                difficulty_breakup = ExamDifficultyBreakup.create(:exam =>exam, :difficulty_level => level, :count => 0)
            end
        end
    end 
end
#Calculating EntityScore For Entity: Question,Topics,Subjects,
Exam.all.each do |exam|
    ExamAttempt.where(:exam => exam).each do |attempt|
        Question.where(:exam => exam).each do |question|
            puts "Question Score to be saved"+exam.name+"Ques. No. "+question.sequence_number.to_s+"Roll no. "+attempt.user.roll_number
            question_score = UserQuestionScore.where(:question => question, :exam_attempt => attempt).first
            question_score = UserQuestionScore.create(:question => question, :value => 0, :exam_attempt => attempt,
                :bonus => false, :partial => false, :blank => false, :correct => false, :incorrect => false) if not question_score
            puts "Question Attribute "+question.bonus.to_s+question.partial.to_s
            if question.bonus
                question_score.value = question_score.value + question.correct_score
                question_score.bonus = true
            elsif question.partial
                AttemptAnswer.where(:exam_attempt => attempt).each do |attempt_answer|
                    if attempt_answer.answer.correct
                        question_score.value = question_score.value + question.per_option_score 
                        question_score.partial = true
                    end
                end
            else
                ans_correct = false
                attempt_answer_array = AttemptAnswer.where(:exam_attempt => attempt, :question => question)
                if attempt_answer_array.length ==0 
                    question_score.value = question_score.value + question.blank_score
                    question_score.blank = true
                else
                    correct_answer = Answer.where(:question => question, :correct => true)
                    p attempt_answer_array[0].answer.option_text
                    p correct_answer[0].option_text
                    puts "Correct Answer Score "+question.correct_score.to_s
                    attempt_answer_array = attempt_answer_array.map{|x| x[:answer_id]}
                    correct_answer = correct_answer.map{|x| x[:id]}
                    p attempt_answer_array
                    p correct_answer
                    ans_correct = (attempt_answer_array.sort == correct_answer.sort)
                    if ans_correct
                        question_score.value = question_score.value + question.correct_score
                        question_score.correct = true ; question_score.incorrect = false
                    else 
                        question_score.value = question_score.value + question.incorrect_score
                        question_score.correct = false ; question_score.incorrect = true
                    end
                end
            end
            puts "Question Score to be saved"+exam.name+"Ques. No. "+question.sequence_number.to_s+"Roll no. "+attempt.user.roll_number+" Value: "+question_score.value.to_s
            question_score.save!
        end
    end
end
Exam.all.each do |exam|
    ExamAttempt.where(:exam => exam).each do |attempt|
        Question.where(:exam => exam).each do |question|
            puts "Question Score to be saved"+exam.name+"Ques. No. "+question.sequence_number.to_s+"Roll no. "+attempt.user.roll_number
            question_score = UserQuestionScore.where(:question => question, :exam_attempt => attempt).first
            
            subject_score = EntityScore.where(:entity_type =>'Subject', :entity_id => question.subject.id,  :exam_attempt => attempt).first
            subject_score = EntityScore.create(:entity_type =>'Subject', :entity_id => question.subject.id, :exam_attempt => attempt, 
                :value =>0, :correct_count => 0, :incorrect_count => 0, :bonus_count => 0, :partial_count => 0, :blank_count => 0) if not subject_score
            subject_score.value = subject_score.value + question_score.value
            subject_score.correct_count = subject_score.correct_count+1 if question_score.correct
            subject_score.incorrect_count = subject_score.incorrect_count+1 if question_score.incorrect
            subject_score.bonus_count = subject_score.bonus_count+1 if question_score.bonus
            subject_score.partial_count = subject_score.partial_count+1 if question_score.partial
            subject_score.blank_count = subject_score.blank_count+1 if question_score.blank
            puts "Subject Score to be updated"+exam.name+"Ques. No. "+question.subject.name+"Roll no. "+attempt.user.roll_number+" Value: "+subject_score.value.to_s
            subject_score.save!
            
            topic_score = EntityScore.where(:entity_type =>'Topic', :entity_id => question.topic.id,  :exam_attempt => attempt).first
            topic_score = EntityScore.create(:entity_type =>'Topic', :entity_id => question.topic.id, :exam_attempt => attempt, 
                :value =>0, :correct_count => 0, :incorrect_count => 0, :bonus_count => 0, :partial_count => 0, :blank_count => 0) if not topic_score
            topic_score.value = topic_score.value + question_score.value
            topic_score.correct_count = topic_score.correct_count+1 if question_score.correct
            topic_score.incorrect_count = topic_score.incorrect_count+1 if question_score.incorrect
            topic_score.bonus_count = topic_score.bonus_count+1 if question_score.bonus
            topic_score.partial_count = topic_score.partial_count+1 if question_score.partial
            topic_score.blank_count = topic_score.blank_count+1 if question_score.blank
            puts "Topic Score to be updated"+exam.name+"Ques. No. "+question.topic.name+"Roll no. "+attempt.user.roll_number+" Value: "+topic_score.value.to_s
            topic_score.save!

            standard_score = EntityScore.where(:entity_type =>'Standard', :entity_id => question.standard.id, :exam_attempt => attempt).first
            standard_score = EntityScore.create(:entity_type =>'Standard', :entity_id => question.standard.id, :exam_attempt => attempt, 
                :value =>0, :correct_count => 0, :incorrect_count => 0, :bonus_count => 0, :partial_count => 0, :blank_count => 0) if not standard_score
            standard_score.value = standard_score.value + question_score.value
            standard_score.correct_count = standard_score.correct_count+1 if question_score.correct
            standard_score.incorrect_count = standard_score.incorrect_count+1 if question_score.incorrect
            standard_score.bonus_count = standard_score.bonus_count+1 if question_score.bonus
            standard_score.partial_count = standard_score.partial_count+1 if question_score.partial
            standard_score.blank_count = standard_score.blank_count+1 if question_score.blank
            puts "Standard Score to be updated"+exam.name+"Ques. No. "+question.standard.name+"Roll no. "+attempt.user.roll_number+" Value: "+standard_score.value.to_s
            standard_score.save!
        end
    end
end
#Calculating UserExamDifficultyBreakup
Exam.all.each do |exam|
    ExamAttempt.where(:exam => exam).each do |attempt|
        Question.where(:exam => exam).each do |question|
            question_score = UserQuestionScore.where(:question => question, :exam_attempt => attempt).first
            user_breakup = UserExamDifficultyBreakup.where(:exam_attempt => attempt, :difficulty_level => question.difficulty_level).first
            user_breakup = UserExamDifficultyBreakup.create(:exam_attempt => attempt, :difficulty_level => question.difficulty_level,
                :correct => 0, :incorrect => 0, :attempted => 0) if not user_breakup
            user_breakup.correct = user_breakup.correct+1 if question_score.correct
            user_breakup.incorrect = user_breakup.incorrect+1 if question_score.incorrect
            user_breakup.attempted = user_breakup.attempted+1 if question_score.partial || question_score.incorrect || question_score.correct
            user_breakup.save!
        end
    end
end
#Calculating ExamReferenceScore For Entity: Subjects,
Exam.all.each do |exam|
    Subject.all.each do |subject|
        exam_ref_score = ExamReferenceScore.where(:entity_type =>'Subject', :entity_id => subject.id, :exam => exam).first
        exam_ref_score = ExamReferenceScore.create(:entity_type =>'Subject', :entity_id => subject.id, :exam => exam, 
                :average =>0, :maximum => 0, :highest => 0, :lowest => 0) if not exam_ref_score
        value_arr =[]
        ExamAttempt.where(:exam => exam).each do |attempt|
            user_score = EntityScore.where(:exam_attempt => attempt,:entity_type => 'Subject', :entity_id => subject.id).first
            puts "Adding user ques score "+user_score.value.to_s
            value_arr << user_score.value
        end
        exam_ref_score.highest = value_arr.max
        exam_ref_score.lowest = value_arr.min
        exam_ref_score.average = value_arr.inject{ |sum, el| sum + el }.to_f / value_arr.size
        exam_ref_score.maximum=0
        Question.where(:exam => exam, :subject => subject).each do |question|
            exam_ref_score.maximum = exam_ref_score.maximum + question.correct_score if not question.bonus
            exam_ref_score.maximum = exam_ref_score.maximum + question.bonus_score if question.bonus
        end
        p exam_ref_score
        exam_ref_score.save!
    end
    Topic.all.each do |topic|
        if EntityScore.where(:entity_type =>'Topic', :entity_id => topic.id).size >0
            exam_ref_score = ExamReferenceScore.where(:entity_type =>'Topic', :entity_id => topic.id, :exam => exam).first
            exam_ref_score = ExamReferenceScore.create(:entity_type =>'Topic', :entity_id => topic.id, :exam => exam, 
                    :average =>0, :maximum => 0, :highest => 0, :lowest => 0) if not exam_ref_score
            value_arr =[]
            ExamAttempt.where(:exam => exam).each do |attempt|
                user_score = EntityScore.where(:exam_attempt => attempt,:entity_type => 'Topic', :entity_id => topic.id).first
                if user_score
                    puts "Adding user ques score "+user_score.value.to_s
                    value_arr << user_score.value
                end
            end
            exam_ref_score.highest = value_arr.max
            exam_ref_score.lowest = value_arr.min
            exam_ref_score.average = value_arr.inject{ |sum, el| sum + el }.to_f / value_arr.size if value_arr.size >0
            exam_ref_score.average = 0 if value_arr.size ==0
            exam_ref_score.maximum=0
            Question.where(:exam => exam, :topic => topic).each do |question|
                exam_ref_score.maximum = exam_ref_score.maximum + question.correct_score if not question.bonus
                exam_ref_score.maximum = exam_ref_score.maximum + question.bonus_score if question.bonus
            end
            p exam_ref_score
            exam_ref_score.save!
        end
    end
    Standard.all.each do |standard|
        exam_ref_score = ExamReferenceScore.where(:entity_type =>'Standard', :entity_id => standard.id, :exam => exam).first
        exam_ref_score = ExamReferenceScore.create(:entity_type =>'Standard', :entity_id => standard.id, :exam => exam, 
                :average =>0, :maximum => 0, :highest => 0, :lowest => 0) if not exam_ref_score
        value_arr =[]
        ExamAttempt.where(:exam => exam).each do |attempt|
            user_score = EntityScore.where(:exam_attempt => attempt,:entity_type => 'Standard', :entity_id => standard.id).first
            puts "Adding user ques score "+user_score.value.to_s
            value_arr << user_score.value
        end
        exam_ref_score.highest = value_arr.max
        exam_ref_score.lowest = value_arr.min
        exam_ref_score.average = value_arr.inject{ |sum, el| sum + el }.to_f / value_arr.size
        exam_ref_score.maximum=0
        Question.where(:exam => exam, :standard => standard).each do |question|
            exam_ref_score.maximum = exam_ref_score.maximum + question.correct_score if not question.bonus
            exam_ref_score.maximum = exam_ref_score.maximum + question.bonus_score if question.bonus
        end
        p exam_ref_score
        exam_ref_score.save!
    end
end
#Generating Score Name
score_names = ['Strong','Average','Weak']
score_min = [0.75,0.25,0]
score_max = [1,0.75,0.25]
score_names.each_with_index do |score_name, index|
    score = ScoreName.where(:display_text => score_name).first
    score = ScoreName.create(:display_text => score_name) if not score
    score.update_columns(:max => score_max[index], :min => score_min[index])
    score.save!
end

EntityScore.all.each do |entity_score|
    user_score = entity_score.value
    p entity_score.entity_type
    p entity_score.entity_id
    p entity_score.exam_attempt.exam
    max_score = ExamReferenceScore.where(:entity_type =>entity_score.entity_type, :entity_id => entity_score.entity_id, :exam => entity_score.exam_attempt.exam).first
    if max_score && max_score.maximum!=0
        entity_score.effective_score = (user_score.to_f/max_score.maximum)
        ScoreName.all.each do |score_name|
            p entity_score.effective_score.to_f
            p score_name.min.to_f
            p score_name.max.to_f
            entity_score.score_name = score_name if entity_score.effective_score.between?(score_name.min,score_name.max)
            puts "Score name"+entity_score.score_name.display_text if entity_score.score_name
        end
        entity_score.save!
    end
end
#Calculating UserGroupReferenceScore For Entity: Subjects,
Exam.all.each do |exam|
    Subject.all.each do |subject|
        subject_score_arr = []
        ExamAttempt.where(:exam => exam).each do |attempt|
            subject_score_arr << EntityScore.where(:entity_type =>'Subject', :entity_id => subject.id,  :exam_attempt => attempt).first.value
        end
        subject_score_arr.sort
        EntityScore.where(:entity_type =>'Subject', :entity_id => subject.id).each do |entity_score|
            if (exam == entity_score.exam_attempt.exam)
                user_ref_score = UserGroupReferenceScore.where(:entity_type =>'Subject', :entity_id => subject.id, :entity_score => entity_score).first
                user_ref_score = UserGroupReferenceScore.create(:entity_type =>'Subject', :entity_id => subject.id, :entity_score => entity_score) if not user_ref_score
                p user_ref_score
                p subject_score_arr.size
                p subject_score_arr.index(entity_score.value)
                p subject_score_arr.size - subject_score_arr.index(entity_score.value)+1
                user_ref_score.rank = subject_score_arr.size - subject_score_arr.index(entity_score.value)+1
                p (subject_score_arr.index(entity_score.value)).to_f*100/subject_score_arr.size
                user_ref_score.percentile = (subject_score_arr.index(entity_score.value)).to_f*100/subject_score_arr.size
                user_ref_score.save!
            end
        end
    end
    Standard.all.each do |standard|
        standard_score_arr = []
        ExamAttempt.where(:exam => exam).each do |attempt|
            standard_score_arr << EntityScore.where(:entity_type =>'Standard', :entity_id => standard.id,  :exam_attempt => attempt).first.value
        end
        standard_score_arr.sort
        EntityScore.where(:entity_type =>'Standard', :entity_id => standard.id).each do |entity_score|
            if (exam == entity_score.exam_attempt.exam)
                user_ref_score = UserGroupReferenceScore.where(:entity_type =>'Standard', :entity_id => standard.id, :entity_score => entity_score).first
                user_ref_score = UserGroupReferenceScore.create(:entity_type =>'Standard', :entity_id => standard.id, :entity_score => entity_score) if not user_ref_score
                user_ref_score.rank = standard_score_arr.size - standard_score_arr.index(entity_score.value)+1
                user_ref_score.percentile = (standard_score_arr.index(entity_score.value)).to_f*100/standard_score_arr.size
                user_ref_score.save!
            end
        end
    end
end
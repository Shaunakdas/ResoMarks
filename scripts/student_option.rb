require 'rubyXL'
exam_name="IAT_IJSO(07-05-2017)"
exam=Exam.find_or_create_by(:name=>exam_name)
exam.save!
puts "Exam Record Generated Id:"+exam.id.to_s+" name"+exam.name

exam_set=ExamSet.find_or_create_by(:name=>exam_name, :exam_id=> exam.id)
exam_set.save!
puts "ExamSet Record Generated Id:"+exam_set.id.to_s+" name"+exam_set.name

# ExamAttempt Array 
exam_attempt_arr = []

book = RubyXL::Parser.parse('/Users/shaunakdas2020/Documents/workspace/reso_marks/scripts/01_IAT_IJSO_KOTA_07-05-2017.xlsx')
scq_sheet = book[0]
title_row_index = 0
row_start = 1
col_start = 0
scq_sheet.each_with_index do |row, index|
  #Accomodating top rows
  next if index <row_start
  # Only start processing if Question Number is present
  if (row.cells[col_start])
    #Tracking question Number
    count = index

    # Adding Exam Name to user
    # exam_name = row.cells[col_start].value
    # puts "Exam Name:"+exam_name
    # subject = Exam.find_by(:name => exam_name)
    
    # Getting Roll No to identify
    roll_num = row.cells[col_start].value
    puts "Roll No :"+roll_num.to_s
    user = User.find_or_create_by(:roll_number => roll_num)
    user.save!
    puts "User Record Generated Id:"+user.id.to_s+" name"+user.roll_number

    exam_attempt = ExamAttempt.find_or_create_by(:user => user, :exam => exam, :exam_set => exam_set)
    exam_attempt.save!
    puts "ExamAttempt Record Generated Id:"+exam_attempt.id.to_s
    exam_attempt_arr << exam_attempt.id

    # Getting Standard to identify question
    #?? Standard is fixed for user or for question?
    # standard_name = row.cells[col_start+1].value
    # puts "Roll No :"+standard_name
    # standard = Standard.find_by(:name => standard_name)
    
    # Adding Paper Code to user
    # paper_code_name = row.cells[col_start+2].value
    # puts "Paper Code:"+paper_code_name
    # paper_code = PaperCode.find_by(:name => paper_code_name)
    ques_count = 1

    while(scq_sheet[title_row_index].cells[col_start+2+ques_count].value[0..2]=="QUE")
        col = col_start+2+ques_count
        question = Question.find_by(:sequence_number => ques_count, :exam => exam)
        puts "Question Record Generated Id:"+question.id.to_s
        # Getting Attempt key of each student for each question
        
        if row.cells[col]
            attempt_key_text = row.cells[col].value
            puts "Attempt Key :"+attempt_key_text.to_s
            if attempt_key_text!="BLANK"
                attempt_key_text.delete! '(,)'
                puts "Answer Key :"+attempt_key_text.to_s
                (attempt_key_text).each_char { |c|
                    chosen_answer = Answer.where(:question => question,:option_text => c.to_s).first
                    if chosen_answer
                        attempt_answer = AttemptAnswer.find_or_create_by(:exam_attempt => exam_attempt, 
                            :answer => chosen_answer,:question => question)  
                        attempt_answer.save!
                        puts "AttemptAnswer Record Generated Id:"+attempt_answer.id.to_s
                    end
                }
            end
        end
        # Adding Question to user score
        puts "Question Serial :"+question.sequence_number.to_s
        # ques = Question.find_by(:exam => exam, :serial => ques_count)

        # user_score = UserScore.create(:user => user, :attempt => attempt_key_text, :question => ques) 
        ques_count = ques_count+1
    end

    # puts "User Score Generated :"+user_score.id
  end
end

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
            user_score = UserQuestionScore.where(:exam_attempt => attempt).first
            puts "Adding user ques score "+user_score.value.to_s
            value_arr << user_score.value
        end
        exam_ref_score.highest = value_arr.max
        exam_ref_score.lowest = value_arr.min
        exam_ref_score.average = value_arr.inject{ |sum, el| sum + el }.to_f / value_arr.size
        Question.where(:exam => exam).each do |question|
            exam_ref_score.maximum = exam_ref_score.maximum + question.correct_score if not question.bonus
            exam_ref_score.maximum = exam_ref_score.maximum + question.bonus_score if question.bonus
        end
        exam_ref_score.save!
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
            user_ref_score = UserGroupReferenceScore.where(:entity_type =>'Subject', :entity_id => subject.id, :entity_score => entity_score).first
            user_ref_score = UserGroupReferenceScore.create(:entity_type =>'Subject', :entity_id => subject.id, :entity_score => entity_score) if not user_ref_score
            user_ref_score.rank = subject_score_arr.size - subject_score_arr.index(entity_score.value)+1
            user_ref_score.percentile = (subject_score_arr.index(entity_score.value)).to_f*100/subject_score_arr.size
            user_ref_score.save!
        end
    end
    Standard.all.each do |standard|
        standard_score_arr = []
        ExamAttempt.where(:exam => exam).each do |attempt|
            standard_score_arr << EntityScore.where(:entity_type =>'Standard', :entity_id => standard.id,  :exam_attempt => attempt).first.value
        end
        standard_score_arr.sort
        EntityScore.where(:entity_type =>'Standard', :entity_id => standard.id).each do |entity_score|
            user_ref_score = UserGroupReferenceScore.where(:entity_type =>'Standard', :entity_id => standard.id, :entity_score => entity_score).first
            user_ref_score = UserGroupReferenceScore.create(:entity_type =>'Standard', :entity_id => standard.id, :entity_score => entity_score) if not user_ref_score
            user_ref_score.rank = standard_score_arr.size - standard_score_arr.index(entity_score.value)+1
            user_ref_score.percentile = (standard_score_arr.index(entity_score.value)).to_f*100/standard_score_arr.size
            user_ref_score.save!
        end
    end
end

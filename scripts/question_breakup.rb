require 'rubyXL'
exam_name="IAT_IJSO(07-05-2017)"
exam=Exam.find_or_create_by(:name=>exam_name)
book = RubyXL::Parser.parse('/scripts/Question_Breakup.xlsx')
scq_sheet = book[0]

row_start = 1
col_start = 0
scq_sheet.each_with_index do |row, index|
  #Accomodating top rows
  next if index <row_start
  # Only start processing if Question Number is present
  if (row.cells[col_start])
    #Tracking question Number
    count = index+1-row_start

    # Adding Sequence Number to question
    sequence_number = row.cells[col_start].value
    puts "Sequence Number:"+sequence_number.to_i.to_s

    # Adding Exam Name to user
    # exam_name = row.cells[col_start].value
    # puts "Exam Name:"+exam_name
    # subject = Exam.find_or_create_by(:name => exam_name)
    
    # Adding Paper Code to user
    # paper_code_name = row.cells[col_start].value
    # puts "Paper Code:"+paper_code_name
    # paper_code = PaperCode.find_or_create_by(:name => paper_code_name)
    
    # Adding Subject to question
    subject_name = row.cells[col_start+1].value
    puts "Subject Name:"+subject_name
    subject = Subject.find_or_create_by(:name => subject_name)
    
    # Adding Topic to question
    topic_name = row.cells[col_start+2].value
    puts "Topic Name:"+topic_name
    topic = Topic.find_or_create_by(:name => topic_name)
    
    # Adding SubTopic to question
    subtopic_name = row.cells[col_start+3].value
    puts "Subtopic Name:"+subtopic_name
    subtopic = Subtopic.find_or_create_by(:name => subtopic_name)

    # Adding Difficulty Level to question
    difficulty_name = row.cells[col_start+4].value
    puts "Difficulty Level :"+difficulty_name
    difficulty = DifficultyLevel.find_or_create_by(:name => difficulty_name)

    # Adding Correct Score to question
    correct_score = row.cells[col_start+5].value
    puts "Correct Score :"+correct_score.to_s
    correct_score = correct_score.to_i

    # Adding Incorrect Score Level to question
    incorrect_score = row.cells[col_start+6].value
    puts "Incorrect Score :"+incorrect_score.to_s
    incorrect_score = incorrect_score.to_i

    # Adding Blank Score to question
    blank_score = row.cells[col_start+7].value
    puts "Blank Score :"+blank_score.to_s
    blank_score = blank_score.to_i

    # Adding Per Option Score to question
    per_option_score = (row.cells[col_start+8])?(row.cells[col_start+8].value.to_i):0
    partial_scoring =(row.cells[col_start+8])?true:false
    # if (row.cells[col_start+8])
    #     per_option_score = row.cells[col_start+8].value
    #     per_option_score = per_option_score.to_i
    # else
    #     partial_scoring =true
    # end
    puts "Per Option Score :"+per_option_score.to_s
    puts "Partial Scoring :"+partial_scoring.to_s

    # Adding Answer Key to question
    answer_key_text = row.cells[col_start+9].value
    puts "Answer Key :"+answer_key_text.to_s
    # answer_key_text = answer_key_text.to_s

    #Bonus Flag
    bonus_flag = (answer_key_text=="bonus")?true:false
    
    # Adding question
    question = Question.find_or_create_by(:sequence_number => sequence_number, :exam => exam)
    question.update_all(:sequence_number => sequence_number, :correct_score => correct_score, :incorrect_score => incorrect_score, :bonus => bonus_flag, 
        :partial => partial_scoring, :blank_score => blank_score, :per_option_score => per_option_score,:exam => exam, :subject => subject, :topic => topic,:serial => count
     :subtopic => subtopic, :difficulty => difficulty )
    
    answers=['A','B','C','D']
    answers.each do |answer|
        Answer.find_or_create_by(:question => question, :option_text => answer)
    end

    (answer_key_text.delete! '(,)').each_char { |c|
        correct_answer = Answer.find_or_create_by(:option_text => c.to_s)
        review.update_column(:correct, true)  
    }

    puts "Question Id Generated :"+question.id
  end
end
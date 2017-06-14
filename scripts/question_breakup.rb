require 'rubyXL'

exam_name="IAT_IJSO(07-05-2017)"
exam=Exam.find_or_create_by(:name=>exam_name)
exam.save!
puts "Exam Record Generated Id:"+exam.id.to_s+" name"+exam.name

exam_set=ExamSet.find_or_create_by(:name=>exam_name, :exam_id=> exam.id)
exam_set.save!
puts "ExamSet Record Generated Id:"+exam_set.id.to_s+" name"+exam_set.name


book = RubyXL::Parser.parse('/Users/shaunakdas2020/Documents/workspace/reso_marks/scripts/Question_Breakup.xlsx')
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
    sequence_number = row.cells[col_start].value.to_i
    puts "Sequence Number:"+sequence_number.to_s

    # Adding Exam Name to user
    # exam_name = row.cells[col_start].value
    # puts "Exam Name:"+exam_name
    # subject = Exam.find_or_create_by(:name => exam_name)
    
    # Adding Paper Code to user
    # paper_code_name = row.cells[col_start].value
    # puts "Paper Code:"+paper_code_name
    # paper_code = PaperCode.find_or_create_by(:name => paper_code_name)
    
    # Adding Standard to question
    standard_name = "10"
    puts "Standard Name:"+standard_name
    standard = Standard.find_or_create_by(:name => standard_name)
    standard.save!
    puts "Standard Record Generated Id:"+standard.id.to_s+" name"+standard.name
    
    # Adding Subject to question
    subject_name = row.cells[col_start+1].value
    puts "Subject Name:"+subject_name
    subject = Subject.find_or_create_by(:name => subject_name)
    subject.save!
    puts "Subject Record Generated Id:"+subject.id.to_s+" name"+subject.name
    
    # Adding Stream to question
    stream_name = subject_name
    puts "Stream Name:"+stream_name
    stream = Stream.find_or_create_by(:name => stream_name,:subject => subject)
    stream.save!
    puts "Stream Record Generated Id:"+stream.id.to_s+" name"+stream.name
    
    # Adding Chapter to question
    chapter_name = row.cells[col_start+2].value
    puts "Chapter Name:"+chapter_name
    chapter = Chapter.find_or_create_by(name: chapter_name,:standard => standard,:subject => subject,:stream => stream)
    chapter.save!
    puts "Chapter Record Generated Id:"+chapter.to_s+" name"+chapter.name
    
    # Adding Topic to question
    topic_name = row.cells[col_start+2].value
    puts "Topic Name:"+topic_name
    topic = Topic.find_or_create_by(name: topic_name,:standard => standard,:subject => subject,:stream => stream,:chapter => chapter)
    topic.save!
    puts "Topic Record Generated Id:"+topic.to_s+" name"+topic.name
    
    # Adding SubTopic to question
    subtopic_name = row.cells[col_start+3].value
    puts "Subtopic Name:"+subtopic_name
    subtopic = Subtopic.find_or_create_by(:name => subtopic_name,:standard => standard,:subject => subject,:topic => topic,:stream => stream,:chapter => chapter)
    subtopic.save!
    puts "Subtopic Record Generated Id:"+subtopic.id.to_s+" name"+subtopic.name

    # Adding Difficulty Level to question
    difficulty_name = row.cells[col_start+4].value
    puts "Difficulty Level :"+difficulty_name
    difficulty = DifficultyLevel.find_or_create_by(:name => difficulty_name)
    difficulty.save!
    puts "DifficultyLevel Record Generated Id:"+difficulty.id.to_s+" name"+difficulty.name

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
    partial_scoring =((row.cells[col_start+8])&&(row.cells[col_start+8].value.to_s.size>0))?true:false
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
    question = Question.where(:sequence_number => sequence_number, :exam_id => exam.id).first
    puts "Question Id searched:"+question.id.to_s if question
    if not question
        new_question = Question.create( :partial => partial_scoring,:correct_score => correct_score, 
            :incorrect_score => incorrect_score, :blank_score => blank_score, :per_option_score => per_option_score,
            :difficulty_level_id => difficulty.id, :subject_id => subject.id,:standard => standard,:chapter => chapter,
            :stream => stream,:subtopic => subtopic, :sequence_number => sequence_number,:exam => exam,exam_set: exam_set, 
            :bonus => bonus_flag,:topic => topic)
        puts "New Question Id :"+new_question.id.to_s 
        new_question.save!
        question = new_question
    else
        question.update_columns( :partial => partial_scoring,:correct_score => correct_score, 
            :incorrect_score => incorrect_score, :blank_score => blank_score, :per_option_score => per_option_score,
            :difficulty_level_id => difficulty.id, :subject_id => subject.id,:standard_id => standard.id,:chapter_id => chapter.id,
            :stream_id => stream.id,:subtopic_id => subtopic.id, :sequence_number => sequence_number,:exam_id => exam.id,exam_set_id: exam_set.id, 
            :bonus => bonus_flag,:topic_id => topic.id)
        puts "Updated Question Id :"+question.id.to_s
        question.save!
    end
    puts "Question Id(Out of loop) :"+question.id.to_s
    answers=['A','B','C','D']
    answers.each do |answer|
        Answer.find_or_create_by(:question => question, :option_text => answer)
    end

    puts "Answer Key :"+answer_key_text.to_s
    if answer_key_text!="bonus"
        answer_key_text.delete! '(,)'
        puts "Answer Key :"+answer_key_text.to_s
        (answer_key_text).each_char { |c|
            correct_answer = Answer.where(:question => question,:option_text => c.to_s).first
            correct_answer.update_column(:correct, true)  if correct_answer

            incorrect_answer = Answer.where(:question => question).where.not(:option_text => c.to_s).first
            incorrect_answer.update_column(:correct, false)  if incorrect_answer
        }
    end

    puts "Question Id Generated :"+question.id.to_s
  end
end
require 'rubyXL'
exam_name="IAT2-(CT) (21-05-17)"
# exam_name="IAT1 (07-05-2017)"
exam=Exam.find_or_create_by(:name=>exam_name)
exam.save!
puts "Exam Record Generated Id:"+exam.id.to_s+" name"+exam.name

exam_set=ExamSet.find_or_create_by(:name=>exam_name, :exam_id=> exam.id)
exam_set.save!
puts "ExamSet Record Generated Id:"+exam_set.id.to_s+" name"+exam_set.name

# ExamAttempt Array 
exam_attempt_arr = []

book = RubyXL::Parser.parse('/Users/shaunakdas2020/Documents/workspace/reso_marks/scripts/01_IAT_IJSO_KOTA_07-05-2017.xlsx')
scq_sheet = book[1]
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



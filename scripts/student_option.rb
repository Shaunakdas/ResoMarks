require 'rubyXL'

book = RubyXL::Parser.parse('../Student_Option.xlsx')
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
    puts "Roll No :"+roll_num
    # user = User.find_by(:roll_num => roll_num)
    
    # Getting Standard to identify question
    #?? Standard is fixed for user or for question?
    standard_name = row.cells[col_start+1].value
    puts "Roll No :"+standard_name
    # standard = Standard.find_by(:name => standard_name)
    
    # Adding Paper Code to user
    # paper_code_name = row.cells[col_start+2].value
    # puts "Paper Code:"+paper_code_name
    # paper_code = PaperCode.find_by(:name => paper_code_name)
    ques_count = 0
    while(scq_sheet[title_row_index].cells[col_start+3+ques_count].value[0..2]=="QUE")
        col = col_start+3+ques_count
        
        # Getting Attempt key of each student for each question
        attempt_key_text = row.cells[col].value
        puts "Attempt Key :"+attempt_key_text
        attempt_key_text == "" if attempt_key_text == "BLANK"

        # Adding Question to user score
        ques_count = ques_count+1
        puts "Question Serial :"+question
        # ques = Question.find_by(:exam => exam, :serial => ques_count)

        user_score = UserScore.create(:user => user, :attempt => attempt_key_text, :question => ques) 
        ques_count = ques_count+1
    end

    puts "User Score Generated :"+user_score.id
  end
end
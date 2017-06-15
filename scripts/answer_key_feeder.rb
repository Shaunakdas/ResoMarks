# require 'rubyXL'

# book = RubyXL::Parser.parse('../01_Revised_Answer Key OAT-1,NAT-1,IAT-1 (07-05-17).xls')
# scq_sheet = book[2]

# row_start = 1
# col_start = 1
# scq_sheet.each_with_index do |row, index|
#   #Accomodating top rows
#   next if index <row_start
#   next if index%2==0

#   col_index=0
#   # Only start processing if Question Number is present
#   while (row.cells[col_start+col_index])
#     #Tracking question Number
#     sequence_number = row.cells[col_start+col_index].value
#     puts "Question Key :"+sequence_number

#     # Adding Answer Key to question
#     answer_key_text = scq_sheet[index+1][col_start+col_index].value
#     puts "Answer Key :"+answer_key_text
#     # answer_key_text = answer_key_text.to_s
    
#     col_index = col_index +1;
#   end
#   index = index+1
# end
require 'spreadsheet'
Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open '01_REVAnswer Key (OCT-1, NCT-1, IAT-(CT) (21-05-17).xls'
scq_sheet = book.worksheets[2]


require 'rubyXL'

write_book = RubyXL::Parser.parse('Question_Breakup.xlsx')
write_sheet = write_book[1]


row_start = 1
col_start = 1
scq_sheet.each_with_index do |row, index|
  #Accomodating top rows
  next if index <row_start
  next if index%2==0

  col_index=0
  # Only start processing if Question Number is present
  while (row[col_start+col_index])
    #Tracking question Number
    sequence_number = row[col_start+col_index]
    puts "Question Key :"+sequence_number.to_i.to_s

    # Adding Answer Key to question
    answer_key_text = scq_sheet.row(index+1)[col_start+col_index]
    puts "Answer Key :"+answer_key_text.to_s
    # answer_key_text = answer_key_text.to_s
    
    # Adding text to required cell in QuestionBreakup file
    write_sheet.add_cell(sequence_number.to_i, 9, answer_key_text)
    
    col_index = col_index +1;
  end
  index = index+1
end
write_book.save
require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get questions_url
    assert_response :success
  end

  test "should get new" do
    get new_question_url
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post questions_url, params: { question: { blank_score: @question.blank_score, chapter_id: @question.chapter_id, correct_score: @question.correct_score, difficulty_level_id: @question.difficulty_level_id, exam_id: @question.exam_id, exam_set_id: @question.exam_set_id, hint_text: @question.hint_text, incorrect_score: @question.incorrect_score, partial: @question.partial, per_option_score: @question.per_option_score, standard_id: @question.standard_id, stream_id: @question.stream_id, subject_id: @question.subject_id, subtopic_id: @question.subtopic_id, text: @question.text } }
    end

    assert_redirected_to question_url(Question.last)
  end

  test "should show question" do
    get question_url(@question)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_url(@question)
    assert_response :success
  end

  test "should update question" do
    patch question_url(@question), params: { question: { blank_score: @question.blank_score, chapter_id: @question.chapter_id, correct_score: @question.correct_score, difficulty_level_id: @question.difficulty_level_id, exam_id: @question.exam_id, exam_set_id: @question.exam_set_id, hint_text: @question.hint_text, incorrect_score: @question.incorrect_score, partial: @question.partial, per_option_score: @question.per_option_score, standard_id: @question.standard_id, stream_id: @question.stream_id, subject_id: @question.subject_id, subtopic_id: @question.subtopic_id, text: @question.text } }
    assert_redirected_to question_url(@question)
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete question_url(@question)
    end

    assert_redirected_to questions_url
  end
end

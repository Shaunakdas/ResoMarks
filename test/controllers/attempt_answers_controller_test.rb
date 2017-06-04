require 'test_helper'

class AttemptAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attempt_answer = attempt_answers(:one)
  end

  test "should get index" do
    get attempt_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_attempt_answer_url
    assert_response :success
  end

  test "should create attempt_answer" do
    assert_difference('AttemptAnswer.count') do
      post attempt_answers_url, params: { attempt_answer: { answer_id: @attempt_answer.answer_id, exam_attempt_id: @attempt_answer.exam_attempt_id, question_id: @attempt_answer.question_id } }
    end

    assert_redirected_to attempt_answer_url(AttemptAnswer.last)
  end

  test "should show attempt_answer" do
    get attempt_answer_url(@attempt_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_attempt_answer_url(@attempt_answer)
    assert_response :success
  end

  test "should update attempt_answer" do
    patch attempt_answer_url(@attempt_answer), params: { attempt_answer: { answer_id: @attempt_answer.answer_id, exam_attempt_id: @attempt_answer.exam_attempt_id, question_id: @attempt_answer.question_id } }
    assert_redirected_to attempt_answer_url(@attempt_answer)
  end

  test "should destroy attempt_answer" do
    assert_difference('AttemptAnswer.count', -1) do
      delete attempt_answer_url(@attempt_answer)
    end

    assert_redirected_to attempt_answers_url
  end
end

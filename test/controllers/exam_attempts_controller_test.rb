require 'test_helper'

class ExamAttemptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_attempt = exam_attempts(:one)
  end

  test "should get index" do
    get exam_attempts_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_attempt_url
    assert_response :success
  end

  test "should create exam_attempt" do
    assert_difference('ExamAttempt.count') do
      post exam_attempts_url, params: { exam_attempt: { exam_id: @exam_attempt.exam_id, exam_set_id: @exam_attempt.exam_set_id, name: @exam_attempt.name, user_id: @exam_attempt.user_id } }
    end

    assert_redirected_to exam_attempt_url(ExamAttempt.last)
  end

  test "should show exam_attempt" do
    get exam_attempt_url(@exam_attempt)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_attempt_url(@exam_attempt)
    assert_response :success
  end

  test "should update exam_attempt" do
    patch exam_attempt_url(@exam_attempt), params: { exam_attempt: { exam_id: @exam_attempt.exam_id, exam_set_id: @exam_attempt.exam_set_id, name: @exam_attempt.name, user_id: @exam_attempt.user_id } }
    assert_redirected_to exam_attempt_url(@exam_attempt)
  end

  test "should destroy exam_attempt" do
    assert_difference('ExamAttempt.count', -1) do
      delete exam_attempt_url(@exam_attempt)
    end

    assert_redirected_to exam_attempts_url
  end
end

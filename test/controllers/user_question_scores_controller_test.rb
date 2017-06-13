require 'test_helper'

class UserQuestionScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_question_score = user_question_scores(:one)
  end

  test "should get index" do
    get user_question_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_user_question_score_url
    assert_response :success
  end

  test "should create user_question_score" do
    assert_difference('UserQuestionScore.count') do
      post user_question_scores_url, params: { user_question_score: { blank: @user_question_score.blank, correct: @user_question_score.correct, effective_score: @user_question_score.effective_score, exam_attempt_id: @user_question_score.exam_attempt_id, exam_set_id: @user_question_score.exam_set_id, incorrect: @user_question_score.incorrect, partial: @user_question_score.partial, percentage: @user_question_score.percentage, question_id: @user_question_score.question_id, score_name_id: @user_question_score.score_name_id, value: @user_question_score.value } }
    end

    assert_redirected_to user_question_score_url(UserQuestionScore.last)
  end

  test "should show user_question_score" do
    get user_question_score_url(@user_question_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_question_score_url(@user_question_score)
    assert_response :success
  end

  test "should update user_question_score" do
    patch user_question_score_url(@user_question_score), params: { user_question_score: { blank: @user_question_score.blank, correct: @user_question_score.correct, effective_score: @user_question_score.effective_score, exam_attempt_id: @user_question_score.exam_attempt_id, exam_set_id: @user_question_score.exam_set_id, incorrect: @user_question_score.incorrect, partial: @user_question_score.partial, percentage: @user_question_score.percentage, question_id: @user_question_score.question_id, score_name_id: @user_question_score.score_name_id, value: @user_question_score.value } }
    assert_redirected_to user_question_score_url(@user_question_score)
  end

  test "should destroy user_question_score" do
    assert_difference('UserQuestionScore.count', -1) do
      delete user_question_score_url(@user_question_score)
    end

    assert_redirected_to user_question_scores_url
  end
end

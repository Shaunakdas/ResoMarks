require 'test_helper'

class UserExamDifficultyBreakupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_exam_difficulty_breakup = user_exam_difficulty_breakups(:one)
  end

  test "should get index" do
    get user_exam_difficulty_breakups_url
    assert_response :success
  end

  test "should get new" do
    get new_user_exam_difficulty_breakup_url
    assert_response :success
  end

  test "should create user_exam_difficulty_breakup" do
    assert_difference('UserExamDifficultyBreakup.count') do
      post user_exam_difficulty_breakups_url, params: { user_exam_difficulty_breakup: { attempted: @user_exam_difficulty_breakup.attempted, correct: @user_exam_difficulty_breakup.correct, difficulty_level_id: @user_exam_difficulty_breakup.difficulty_level_id, exam_attempt_id: @user_exam_difficulty_breakup.exam_attempt_id, incorrect: @user_exam_difficulty_breakup.incorrect } }
    end

    assert_redirected_to user_exam_difficulty_breakup_url(UserExamDifficultyBreakup.last)
  end

  test "should show user_exam_difficulty_breakup" do
    get user_exam_difficulty_breakup_url(@user_exam_difficulty_breakup)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_exam_difficulty_breakup_url(@user_exam_difficulty_breakup)
    assert_response :success
  end

  test "should update user_exam_difficulty_breakup" do
    patch user_exam_difficulty_breakup_url(@user_exam_difficulty_breakup), params: { user_exam_difficulty_breakup: { attempted: @user_exam_difficulty_breakup.attempted, correct: @user_exam_difficulty_breakup.correct, difficulty_level_id: @user_exam_difficulty_breakup.difficulty_level_id, exam_attempt_id: @user_exam_difficulty_breakup.exam_attempt_id, incorrect: @user_exam_difficulty_breakup.incorrect } }
    assert_redirected_to user_exam_difficulty_breakup_url(@user_exam_difficulty_breakup)
  end

  test "should destroy user_exam_difficulty_breakup" do
    assert_difference('UserExamDifficultyBreakup.count', -1) do
      delete user_exam_difficulty_breakup_url(@user_exam_difficulty_breakup)
    end

    assert_redirected_to user_exam_difficulty_breakups_url
  end
end

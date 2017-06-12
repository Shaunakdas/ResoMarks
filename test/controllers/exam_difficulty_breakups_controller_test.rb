require 'test_helper'

class ExamDifficultyBreakupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_difficulty_breakup = exam_difficulty_breakups(:one)
  end

  test "should get index" do
    get exam_difficulty_breakups_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_difficulty_breakup_url
    assert_response :success
  end

  test "should create exam_difficulty_breakup" do
    assert_difference('ExamDifficultyBreakup.count') do
      post exam_difficulty_breakups_url, params: { exam_difficulty_breakup: { count: @exam_difficulty_breakup.count, difficulty_level_id: @exam_difficulty_breakup.difficulty_level_id, exam_id: @exam_difficulty_breakup.exam_id } }
    end

    assert_redirected_to exam_difficulty_breakup_url(ExamDifficultyBreakup.last)
  end

  test "should show exam_difficulty_breakup" do
    get exam_difficulty_breakup_url(@exam_difficulty_breakup)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_difficulty_breakup_url(@exam_difficulty_breakup)
    assert_response :success
  end

  test "should update exam_difficulty_breakup" do
    patch exam_difficulty_breakup_url(@exam_difficulty_breakup), params: { exam_difficulty_breakup: { count: @exam_difficulty_breakup.count, difficulty_level_id: @exam_difficulty_breakup.difficulty_level_id, exam_id: @exam_difficulty_breakup.exam_id } }
    assert_redirected_to exam_difficulty_breakup_url(@exam_difficulty_breakup)
  end

  test "should destroy exam_difficulty_breakup" do
    assert_difference('ExamDifficultyBreakup.count', -1) do
      delete exam_difficulty_breakup_url(@exam_difficulty_breakup)
    end

    assert_redirected_to exam_difficulty_breakups_url
  end
end

require 'test_helper'

class TargetExamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @target_exam = target_exams(:one)
  end

  test "should get index" do
    get target_exams_url
    assert_response :success
  end

  test "should get new" do
    get new_target_exam_url
    assert_response :success
  end

  test "should create target_exam" do
    assert_difference('TargetExam.count') do
      post target_exams_url, params: { target_exam: { name: @target_exam.name } }
    end

    assert_redirected_to target_exam_url(TargetExam.last)
  end

  test "should show target_exam" do
    get target_exam_url(@target_exam)
    assert_response :success
  end

  test "should get edit" do
    get edit_target_exam_url(@target_exam)
    assert_response :success
  end

  test "should update target_exam" do
    patch target_exam_url(@target_exam), params: { target_exam: { name: @target_exam.name } }
    assert_redirected_to target_exam_url(@target_exam)
  end

  test "should destroy target_exam" do
    assert_difference('TargetExam.count', -1) do
      delete target_exam_url(@target_exam)
    end

    assert_redirected_to target_exams_url
  end
end

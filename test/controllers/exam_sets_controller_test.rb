require 'test_helper'

class ExamSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_set = exam_sets(:one)
  end

  test "should get index" do
    get exam_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_set_url
    assert_response :success
  end

  test "should create exam_set" do
    assert_difference('ExamSet.count') do
      post exam_sets_url, params: { exam_set: { code: @exam_set.code, exam_date: @exam_set.exam_date, exam_id: @exam_set.exam_id, name: @exam_set.name, sequence_number: @exam_set.sequence_number } }
    end

    assert_redirected_to exam_set_url(ExamSet.last)
  end

  test "should show exam_set" do
    get exam_set_url(@exam_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_set_url(@exam_set)
    assert_response :success
  end

  test "should update exam_set" do
    patch exam_set_url(@exam_set), params: { exam_set: { code: @exam_set.code, exam_date: @exam_set.exam_date, exam_id: @exam_set.exam_id, name: @exam_set.name, sequence_number: @exam_set.sequence_number } }
    assert_redirected_to exam_set_url(@exam_set)
  end

  test "should destroy exam_set" do
    assert_difference('ExamSet.count', -1) do
      delete exam_set_url(@exam_set)
    end

    assert_redirected_to exam_sets_url
  end
end

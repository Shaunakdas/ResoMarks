require 'test_helper'

class ExamReferenceScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_reference_score = exam_reference_scores(:one)
  end

  test "should get index" do
    get exam_reference_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_reference_score_url
    assert_response :success
  end

  test "should create exam_reference_score" do
    assert_difference('ExamReferenceScore.count') do
      post exam_reference_scores_url, params: { exam_reference_score: { average: @exam_reference_score.average, entity_id: @exam_reference_score.entity_id, entity_type: @exam_reference_score.entity_type, exam_id: @exam_reference_score.exam_id, highest: @exam_reference_score.highest, lowest: @exam_reference_score.lowest, maximum: @exam_reference_score.maximum } }
    end

    assert_redirected_to exam_reference_score_url(ExamReferenceScore.last)
  end

  test "should show exam_reference_score" do
    get exam_reference_score_url(@exam_reference_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_reference_score_url(@exam_reference_score)
    assert_response :success
  end

  test "should update exam_reference_score" do
    patch exam_reference_score_url(@exam_reference_score), params: { exam_reference_score: { average: @exam_reference_score.average, entity_id: @exam_reference_score.entity_id, entity_type: @exam_reference_score.entity_type, exam_id: @exam_reference_score.exam_id, highest: @exam_reference_score.highest, lowest: @exam_reference_score.lowest, maximum: @exam_reference_score.maximum } }
    assert_redirected_to exam_reference_score_url(@exam_reference_score)
  end

  test "should destroy exam_reference_score" do
    assert_difference('ExamReferenceScore.count', -1) do
      delete exam_reference_score_url(@exam_reference_score)
    end

    assert_redirected_to exam_reference_scores_url
  end
end

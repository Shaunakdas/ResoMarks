require 'test_helper'

class EntityScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entity_score = entity_scores(:one)
  end

  test "should get index" do
    get entity_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_entity_score_url
    assert_response :success
  end

  test "should create entity_score" do
    assert_difference('EntityScore.count') do
      post entity_scores_url, params: { entity_score: { entity_id: @entity_score.entity_id, entity_type: @entity_score.entity_type, exam_id: @entity_score.exam_id, exam_set_id: @entity_score.exam_set_id, user_id: @entity_score.user_id } }
    end

    assert_redirected_to entity_score_url(EntityScore.last)
  end

  test "should show entity_score" do
    get entity_score_url(@entity_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_entity_score_url(@entity_score)
    assert_response :success
  end

  test "should update entity_score" do
    patch entity_score_url(@entity_score), params: { entity_score: { entity_id: @entity_score.entity_id, entity_type: @entity_score.entity_type, exam_id: @entity_score.exam_id, exam_set_id: @entity_score.exam_set_id, user_id: @entity_score.user_id } }
    assert_redirected_to entity_score_url(@entity_score)
  end

  test "should destroy entity_score" do
    assert_difference('EntityScore.count', -1) do
      delete entity_score_url(@entity_score)
    end

    assert_redirected_to entity_scores_url
  end
end

require 'test_helper'

class UserGroupReferenceScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_group_reference_score = user_group_reference_scores(:one)
  end

  test "should get index" do
    get user_group_reference_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_user_group_reference_score_url
    assert_response :success
  end

  test "should create user_group_reference_score" do
    assert_difference('UserGroupReferenceScore.count') do
      post user_group_reference_scores_url, params: { user_group_reference_score: { entity_id: @user_group_reference_score.entity_id, entity_type: @user_group_reference_score.entity_type, group_id: @user_group_reference_score.group_id, group_type: @user_group_reference_score.group_type, percentile: @user_group_reference_score.percentile, rank: @user_group_reference_score.rank, user_entity_score_id: @user_group_reference_score.user_entity_score_id } }
    end

    assert_redirected_to user_group_reference_score_url(UserGroupReferenceScore.last)
  end

  test "should show user_group_reference_score" do
    get user_group_reference_score_url(@user_group_reference_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_group_reference_score_url(@user_group_reference_score)
    assert_response :success
  end

  test "should update user_group_reference_score" do
    patch user_group_reference_score_url(@user_group_reference_score), params: { user_group_reference_score: { entity_id: @user_group_reference_score.entity_id, entity_type: @user_group_reference_score.entity_type, group_id: @user_group_reference_score.group_id, group_type: @user_group_reference_score.group_type, percentile: @user_group_reference_score.percentile, rank: @user_group_reference_score.rank, user_entity_score_id: @user_group_reference_score.user_entity_score_id } }
    assert_redirected_to user_group_reference_score_url(@user_group_reference_score)
  end

  test "should destroy user_group_reference_score" do
    assert_difference('UserGroupReferenceScore.count', -1) do
      delete user_group_reference_score_url(@user_group_reference_score)
    end

    assert_redirected_to user_group_reference_scores_url
  end
end

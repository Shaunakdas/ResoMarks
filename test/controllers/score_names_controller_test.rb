require 'test_helper'

class ScoreNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @score_name = score_names(:one)
  end

  test "should get index" do
    get score_names_url
    assert_response :success
  end

  test "should get new" do
    get new_score_name_url
    assert_response :success
  end

  test "should create score_name" do
    assert_difference('ScoreName.count') do
      post score_names_url, params: { score_name: { display_text: @score_name.display_text, max: @score_name.max, max_include: @score_name.max_include, min: @score_name.min, min_include: @score_name.min_include } }
    end

    assert_redirected_to score_name_url(ScoreName.last)
  end

  test "should show score_name" do
    get score_name_url(@score_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_score_name_url(@score_name)
    assert_response :success
  end

  test "should update score_name" do
    patch score_name_url(@score_name), params: { score_name: { display_text: @score_name.display_text, max: @score_name.max, max_include: @score_name.max_include, min: @score_name.min, min_include: @score_name.min_include } }
    assert_redirected_to score_name_url(@score_name)
  end

  test "should destroy score_name" do
    assert_difference('ScoreName.count', -1) do
      delete score_name_url(@score_name)
    end

    assert_redirected_to score_names_url
  end
end

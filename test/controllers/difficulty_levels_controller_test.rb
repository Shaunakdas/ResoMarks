require 'test_helper'

class DifficultyLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @difficulty_level = difficulty_levels(:one)
  end

  test "should get index" do
    get difficulty_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_difficulty_level_url
    assert_response :success
  end

  test "should create difficulty_level" do
    assert_difference('DifficultyLevel.count') do
      post difficulty_levels_url, params: { difficulty_level: { code: @difficulty_level.code, name: @difficulty_level.name, number: @difficulty_level.number, value: @difficulty_level.value } }
    end

    assert_redirected_to difficulty_level_url(DifficultyLevel.last)
  end

  test "should show difficulty_level" do
    get difficulty_level_url(@difficulty_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_difficulty_level_url(@difficulty_level)
    assert_response :success
  end

  test "should update difficulty_level" do
    patch difficulty_level_url(@difficulty_level), params: { difficulty_level: { code: @difficulty_level.code, name: @difficulty_level.name, number: @difficulty_level.number, value: @difficulty_level.value } }
    assert_redirected_to difficulty_level_url(@difficulty_level)
  end

  test "should destroy difficulty_level" do
    assert_difference('DifficultyLevel.count', -1) do
      delete difficulty_level_url(@difficulty_level)
    end

    assert_redirected_to difficulty_levels_url
  end
end

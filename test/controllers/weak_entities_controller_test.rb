require 'test_helper'

class WeakEntitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weak_entity = weak_entities(:one)
  end

  test "should get index" do
    get weak_entities_url
    assert_response :success
  end

  test "should get new" do
    get new_weak_entity_url
    assert_response :success
  end

  test "should create weak_entity" do
    assert_difference('WeakEntity.count') do
      post weak_entities_url, params: { weak_entity: { entity_id: @weak_entity.entity_id, entity_type: @weak_entity.entity_type, exam_attempt_id: @weak_entity.exam_attempt_id } }
    end

    assert_redirected_to weak_entity_url(WeakEntity.last)
  end

  test "should show weak_entity" do
    get weak_entity_url(@weak_entity)
    assert_response :success
  end

  test "should get edit" do
    get edit_weak_entity_url(@weak_entity)
    assert_response :success
  end

  test "should update weak_entity" do
    patch weak_entity_url(@weak_entity), params: { weak_entity: { entity_id: @weak_entity.entity_id, entity_type: @weak_entity.entity_type, exam_attempt_id: @weak_entity.exam_attempt_id } }
    assert_redirected_to weak_entity_url(@weak_entity)
  end

  test "should destroy weak_entity" do
    assert_difference('WeakEntity.count', -1) do
      delete weak_entity_url(@weak_entity)
    end

    assert_redirected_to weak_entities_url
  end
end

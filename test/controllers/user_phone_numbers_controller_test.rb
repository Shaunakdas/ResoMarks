require 'test_helper'

class UserPhoneNumbersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_phone_number = user_phone_numbers(:one)
  end

  test "should get index" do
    get user_phone_numbers_url
    assert_response :success
  end

  test "should get new" do
    get new_user_phone_number_url
    assert_response :success
  end

  test "should create user_phone_number" do
    assert_difference('UserPhoneNumber.count') do
      post user_phone_numbers_url, params: { user_phone_number: { number: @user_phone_number.number, user_id: @user_phone_number.user_id } }
    end

    assert_redirected_to user_phone_number_url(UserPhoneNumber.last)
  end

  test "should show user_phone_number" do
    get user_phone_number_url(@user_phone_number)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_phone_number_url(@user_phone_number)
    assert_response :success
  end

  test "should update user_phone_number" do
    patch user_phone_number_url(@user_phone_number), params: { user_phone_number: { number: @user_phone_number.number, user_id: @user_phone_number.user_id } }
    assert_redirected_to user_phone_number_url(@user_phone_number)
  end

  test "should destroy user_phone_number" do
    assert_difference('UserPhoneNumber.count', -1) do
      delete user_phone_number_url(@user_phone_number)
    end

    assert_redirected_to user_phone_numbers_url
  end
end

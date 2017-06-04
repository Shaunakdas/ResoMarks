require 'test_helper'

class AuthTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_token = auth_tokens(:one)
  end

  test "should get index" do
    get auth_tokens_url
    assert_response :success
  end

  test "should get new" do
    get new_auth_token_url
    assert_response :success
  end

  test "should create auth_token" do
    assert_difference('AuthToken.count') do
      post auth_tokens_url, params: { auth_token: { auth_token: @auth_token.auth_token, device_id: @auth_token.device_id, number: @auth_token.number, otp: @auth_token.otp, user_id: @auth_token.user_id } }
    end

    assert_redirected_to auth_token_url(AuthToken.last)
  end

  test "should show auth_token" do
    get auth_token_url(@auth_token)
    assert_response :success
  end

  test "should get edit" do
    get edit_auth_token_url(@auth_token)
    assert_response :success
  end

  test "should update auth_token" do
    patch auth_token_url(@auth_token), params: { auth_token: { auth_token: @auth_token.auth_token, device_id: @auth_token.device_id, number: @auth_token.number, otp: @auth_token.otp, user_id: @auth_token.user_id } }
    assert_redirected_to auth_token_url(@auth_token)
  end

  test "should destroy auth_token" do
    assert_difference('AuthToken.count', -1) do
      delete auth_token_url(@auth_token)
    end

    assert_redirected_to auth_tokens_url
  end
end

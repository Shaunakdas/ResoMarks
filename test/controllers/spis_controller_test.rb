require 'test_helper'

class SpisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spi = spis(:one)
  end

  test "should get index" do
    get spis_url
    assert_response :success
  end

  test "should get new" do
    get new_spi_url
    assert_response :success
  end

  test "should create spi" do
    assert_difference('Spi.count') do
      post spis_url, params: { spi: { exam_attempt_id: @spi.exam_attempt_id, target_exam_id: @spi.target_exam_id, value: @spi.value } }
    end

    assert_redirected_to spi_url(Spi.last)
  end

  test "should show spi" do
    get spi_url(@spi)
    assert_response :success
  end

  test "should get edit" do
    get edit_spi_url(@spi)
    assert_response :success
  end

  test "should update spi" do
    patch spi_url(@spi), params: { spi: { exam_attempt_id: @spi.exam_attempt_id, target_exam_id: @spi.target_exam_id, value: @spi.value } }
    assert_redirected_to spi_url(@spi)
  end

  test "should destroy spi" do
    assert_difference('Spi.count', -1) do
      delete spi_url(@spi)
    end

    assert_redirected_to spis_url
  end
end

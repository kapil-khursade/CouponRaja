require "test_helper"

class BusinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @busine = busines(:one)
  end

  test "should get index" do
    get busines_url
    assert_response :success
  end

  test "should get new" do
    get new_busine_url
    assert_response :success
  end

  test "should create busine" do
    assert_difference("Busine.count") do
      post busines_url, params: { busine: {} }
    end

    assert_redirected_to busine_url(Busine.last)
  end

  test "should show busine" do
    get busine_url(@busine)
    assert_response :success
  end

  test "should get edit" do
    get edit_busine_url(@busine)
    assert_response :success
  end

  test "should update busine" do
    patch busine_url(@busine), params: { busine: {} }
    assert_redirected_to busine_url(@busine)
  end

  test "should destroy busine" do
    assert_difference("Busine.count", -1) do
      delete busine_url(@busine)
    end

    assert_redirected_to busines_url
  end
end

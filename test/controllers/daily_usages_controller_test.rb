require 'test_helper'

class DailyUsagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_usage = daily_usages(:one)
  end

  test "should get index" do
    get daily_usages_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_usage_url
    assert_response :success
  end

  test "should create daily_usage" do
    assert_difference('DailyUsage.count') do
      post daily_usages_url, params: { daily_usage: { price: @daily_usage.price } }
    end

    assert_redirected_to daily_usage_url(DailyUsage.last)
  end

  test "should show daily_usage" do
    get daily_usage_url(@daily_usage)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_usage_url(@daily_usage)
    assert_response :success
  end

  test "should update daily_usage" do
    patch daily_usage_url(@daily_usage), params: { daily_usage: { price: @daily_usage.price } }
    assert_redirected_to daily_usage_url(@daily_usage)
  end

  test "should destroy daily_usage" do
    assert_difference('DailyUsage.count', -1) do
      delete daily_usage_url(@daily_usage)
    end

    assert_redirected_to daily_usages_url
  end
end

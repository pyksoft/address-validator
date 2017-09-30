require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings(:one)
  end

  test "should get index" do
    get settings_url
    assert_response :success
  end

  test "should get new" do
    get new_setting_url
    assert_response :success
  end

  test "should create setting" do
    assert_difference('Setting.count') do
      post settings_url, params: { setting: { auto_complete: @setting.auto_complete, color_background: @setting.color_background, color_border: @setting.color_border, color_highlight: @setting.color_highlight, color_hover: @setting.color_hover, color_text: @setting.color_text, pobox_warning: @setting.pobox_warning, store_domain: @setting.store_domain, streetnum_warning: @setting.streetnum_warning, text_apt_suite: @setting.text_apt_suite, text_correct: @setting.text_correct, text_inaccurate: @setting.text_inaccurate, text_select_confirm: @setting.text_select_confirm, text_select_suggestion: @setting.text_select_suggestion, text_suggest1: @setting.text_suggest1, text_suggest2: @setting.text_suggest2, validate_address: @setting.validate_address } }
    end

    assert_redirected_to setting_url(Setting.last)
  end

  test "should show setting" do
    get setting_url(@setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting_url(@setting)
    assert_response :success
  end

  test "should update setting" do
    patch setting_url(@setting), params: { setting: { auto_complete: @setting.auto_complete, color_background: @setting.color_background, color_border: @setting.color_border, color_highlight: @setting.color_highlight, color_hover: @setting.color_hover, color_text: @setting.color_text, pobox_warning: @setting.pobox_warning, store_domain: @setting.store_domain, streetnum_warning: @setting.streetnum_warning, text_apt_suite: @setting.text_apt_suite, text_correct: @setting.text_correct, text_inaccurate: @setting.text_inaccurate, text_select_confirm: @setting.text_select_confirm, text_select_suggestion: @setting.text_select_suggestion, text_suggest1: @setting.text_suggest1, text_suggest2: @setting.text_suggest2, validate_address: @setting.validate_address } }
    assert_redirected_to setting_url(@setting)
  end

  test "should destroy setting" do
    assert_difference('Setting.count', -1) do
      delete setting_url(@setting)
    end

    assert_redirected_to settings_url
  end
end

require "test_helper"

class Admins::WritingInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_writing_information = admins_writing_informations(:one)
  end

  test "should get index" do
    get admins_writing_informations_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_writing_information_url
    assert_response :success
  end

  test "should create admins_writing_information" do
    assert_difference('Admins::WritingInformation.count') do
      post admins_writing_informations_url, params: { admins_writing_information: { text1: @admins_writing_information.text1, text2: @admins_writing_information.text2 } }
    end

    assert_redirected_to admins_writing_information_url(Admins::WritingInformation.last)
  end

  test "should show admins_writing_information" do
    get admins_writing_information_url(@admins_writing_information)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_writing_information_url(@admins_writing_information)
    assert_response :success
  end

  test "should update admins_writing_information" do
    patch admins_writing_information_url(@admins_writing_information), params: { admins_writing_information: { text1: @admins_writing_information.text1, text2: @admins_writing_information.text2 } }
    assert_redirected_to admins_writing_information_url(@admins_writing_information)
  end

  test "should destroy admins_writing_information" do
    assert_difference('Admins::WritingInformation.count', -1) do
      delete admins_writing_information_url(@admins_writing_information)
    end

    assert_redirected_to admins_writing_informations_url
  end
end

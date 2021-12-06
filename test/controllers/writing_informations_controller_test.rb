require "test_helper"

class WritingInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @writing_information = writing_informations(:one)
  end

  test "should get index" do
    get writing_informations_url
    assert_response :success
  end

  test "should get new" do
    get new_writing_information_url
    assert_response :success
  end

  test "should create writing_information" do
    assert_difference('WritingInformation.count') do
      post writing_informations_url, params: { writing_information: { text1: @writing_information.text1, text2: @writing_information.text2 } }
    end

    assert_redirected_to writing_information_url(WritingInformation.last)
  end

  test "should show writing_information" do
    get writing_information_url(@writing_information)
    assert_response :success
  end

  test "should get edit" do
    get edit_writing_information_url(@writing_information)
    assert_response :success
  end

  test "should update writing_information" do
    patch writing_information_url(@writing_information), params: { writing_information: { text1: @writing_information.text1, text2: @writing_information.text2 } }
    assert_redirected_to writing_information_url(@writing_information)
  end

  test "should destroy writing_information" do
    assert_difference('WritingInformation.count', -1) do
      delete writing_information_url(@writing_information)
    end

    assert_redirected_to writing_informations_url
  end
end

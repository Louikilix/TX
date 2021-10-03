require "test_helper"

class WritingDefinitionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @writing_definition = writing_definitions(:one)
  end

  test "should get index" do
    get writing_definitions_url
    assert_response :success
  end

  test "should get new" do
    get new_writing_definition_url
    assert_response :success
  end

  test "should create writing_definition" do
    assert_difference('WritingDefinition.count') do
      post writing_definitions_url, params: { writing_definition: {  } }
    end

    assert_redirected_to writing_definition_url(WritingDefinition.last)
  end

  test "should show writing_definition" do
    get writing_definition_url(@writing_definition)
    assert_response :success
  end

  test "should get edit" do
    get edit_writing_definition_url(@writing_definition)
    assert_response :success
  end

  test "should update writing_definition" do
    patch writing_definition_url(@writing_definition), params: { writing_definition: {  } }
    assert_redirected_to writing_definition_url(@writing_definition)
  end

  test "should destroy writing_definition" do
    assert_difference('WritingDefinition.count', -1) do
      delete writing_definition_url(@writing_definition)
    end

    assert_redirected_to writing_definitions_url
  end
end

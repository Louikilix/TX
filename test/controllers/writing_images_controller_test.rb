require "test_helper"

class WritingImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @writing_image = writing_images(:one)
  end

  test "should get index" do
    get writing_images_url
    assert_response :success
  end

  test "should get new" do
    get new_writing_image_url
    assert_response :success
  end

  test "should create writing_image" do
    assert_difference('WritingImage.count') do
      post writing_images_url, params: { writing_image: {  } }
    end

    assert_redirected_to writing_image_url(WritingImage.last)
  end

  test "should show writing_image" do
    get writing_image_url(@writing_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_writing_image_url(@writing_image)
    assert_response :success
  end

  test "should update writing_image" do
    patch writing_image_url(@writing_image), params: { writing_image: {  } }
    assert_redirected_to writing_image_url(@writing_image)
  end

  test "should destroy writing_image" do
    assert_difference('WritingImage.count', -1) do
      delete writing_image_url(@writing_image)
    end

    assert_redirected_to writing_images_url
  end
end

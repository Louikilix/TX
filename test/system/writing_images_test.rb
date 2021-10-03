require "application_system_test_case"

class WritingImagesTest < ApplicationSystemTestCase
  setup do
    @writing_image = writing_images(:one)
  end

  test "visiting the index" do
    visit writing_images_url
    assert_selector "h1", text: "Writing Images"
  end

  test "creating a Writing image" do
    visit writing_images_url
    click_on "New Writing Image"

    click_on "Create Writing image"

    assert_text "Writing image was successfully created"
    click_on "Back"
  end

  test "updating a Writing image" do
    visit writing_images_url
    click_on "Edit", match: :first

    click_on "Update Writing image"

    assert_text "Writing image was successfully updated"
    click_on "Back"
  end

  test "destroying a Writing image" do
    visit writing_images_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Writing image was successfully destroyed"
  end
end

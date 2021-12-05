require "application_system_test_case"

class Admins::WritingInformationsTest < ApplicationSystemTestCase
  setup do
    @admins_writing_information = admins_writing_informations(:one)
  end

  test "visiting the index" do
    visit admins_writing_informations_url
    assert_selector "h1", text: "Admins/Writing Informations"
  end

  test "creating a Writing information" do
    visit admins_writing_informations_url
    click_on "New Admins/Writing Information"

    fill_in "Text1", with: @admins_writing_information.text1
    fill_in "Text2", with: @admins_writing_information.text2
    click_on "Create Writing information"

    assert_text "Writing information was successfully created"
    click_on "Back"
  end

  test "updating a Writing information" do
    visit admins_writing_informations_url
    click_on "Edit", match: :first

    fill_in "Text1", with: @admins_writing_information.text1
    fill_in "Text2", with: @admins_writing_information.text2
    click_on "Update Writing information"

    assert_text "Writing information was successfully updated"
    click_on "Back"
  end

  test "destroying a Writing information" do
    visit admins_writing_informations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Writing information was successfully destroyed"
  end
end

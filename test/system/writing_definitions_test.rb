require "application_system_test_case"

class WritingDefinitionsTest < ApplicationSystemTestCase
  setup do
    @writing_definition = writing_definitions(:one)
  end

  test "visiting the index" do
    visit writing_definitions_url
    assert_selector "h1", text: "Writing Definitions"
  end

  test "creating a Writing definition" do
    visit writing_definitions_url
    click_on "New Writing Definition"

    click_on "Create Writing definition"

    assert_text "Writing definition was successfully created"
    click_on "Back"
  end

  test "updating a Writing definition" do
    visit writing_definitions_url
    click_on "Edit", match: :first

    click_on "Update Writing definition"

    assert_text "Writing definition was successfully updated"
    click_on "Back"
  end

  test "destroying a Writing definition" do
    visit writing_definitions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Writing definition was successfully destroyed"
  end
end

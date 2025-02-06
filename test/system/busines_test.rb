require "application_system_test_case"

class BusinesTest < ApplicationSystemTestCase
  setup do
    @busine = busines(:one)
  end

  test "visiting the index" do
    visit busines_url
    assert_selector "h1", text: "Busines"
  end

  test "should create busine" do
    visit busines_url
    click_on "New busine"

    click_on "Create Busine"

    assert_text "Busine was successfully created"
    click_on "Back"
  end

  test "should update Busine" do
    visit busine_url(@busine)
    click_on "Edit this busine", match: :first

    click_on "Update Busine"

    assert_text "Busine was successfully updated"
    click_on "Back"
  end

  test "should destroy Busine" do
    visit busine_url(@busine)
    click_on "Destroy this busine", match: :first

    assert_text "Busine was successfully destroyed"
  end
end

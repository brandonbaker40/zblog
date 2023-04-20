require "application_system_test_case"

class DocumentedUnitsTest < ApplicationSystemTestCase
  setup do
    @documented_unit = documented_units(:one)
  end

  test "visiting the index" do
    visit documented_units_url
    assert_selector "h1", text: "Documented units"
  end

  test "should create documented unit" do
    visit documented_units_url
    click_on "New documented unit"

    fill_in "Code", with: @documented_unit.code_id
    fill_in "Unit count", with: @documented_unit.unit_count
    fill_in "Visit", with: @documented_unit.visit_id
    click_on "Create Documented unit"

    assert_text "Documented unit was successfully created"
    click_on "Back"
  end

  test "should update Documented unit" do
    visit documented_unit_url(@documented_unit)
    click_on "Edit this documented unit", match: :first

    fill_in "Code", with: @documented_unit.code_id
    fill_in "Unit count", with: @documented_unit.unit_count
    fill_in "Visit", with: @documented_unit.visit_id
    click_on "Update Documented unit"

    assert_text "Documented unit was successfully updated"
    click_on "Back"
  end

  test "should destroy Documented unit" do
    visit documented_unit_url(@documented_unit)
    click_on "Destroy this documented unit", match: :first

    assert_text "Documented unit was successfully destroyed"
  end
end

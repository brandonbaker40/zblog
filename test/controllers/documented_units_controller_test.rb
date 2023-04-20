require "test_helper"

class DocumentedUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @documented_unit = documented_units(:one)
  end

  test "should get index" do
    get documented_units_url
    assert_response :success
  end

  test "should get new" do
    get new_documented_unit_url
    assert_response :success
  end

  test "should create documented_unit" do
    assert_difference("DocumentedUnit.count") do
      post documented_units_url, params: { documented_unit: { code_id: @documented_unit.code_id, unit_count: @documented_unit.unit_count, visit_id: @documented_unit.visit_id } }
    end

    assert_redirected_to documented_unit_url(DocumentedUnit.last)
  end

  test "should show documented_unit" do
    get documented_unit_url(@documented_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_documented_unit_url(@documented_unit)
    assert_response :success
  end

  test "should update documented_unit" do
    patch documented_unit_url(@documented_unit), params: { documented_unit: { code_id: @documented_unit.code_id, unit_count: @documented_unit.unit_count, visit_id: @documented_unit.visit_id } }
    assert_redirected_to documented_unit_url(@documented_unit)
  end

  test "should destroy documented_unit" do
    assert_difference("DocumentedUnit.count", -1) do
      delete documented_unit_url(@documented_unit)
    end

    assert_redirected_to documented_units_url
  end
end

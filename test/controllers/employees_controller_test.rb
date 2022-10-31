require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should show employee" do
    get employee_url(1)
    assert_response :success
  end

end

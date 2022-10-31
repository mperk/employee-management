class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show ]
  before_action :validate_params, only: [:index]
  include Pagination
  PER_PAGE = 5

  # GET /app_services
  def index
    # the reqres.in api does not support filter parameter. Therefore we filter after getting all employees
    if(params[:email].present?)
      response = AppServices::EmployeeService.new.get_all_employees
      @pagination, @employees = paginate(response, params: page_params)
      @employees = @employees.select {|employee| employee["email"].include?(params[:email])}
    else
      response = AppServices::EmployeeService.new.get_employees(page_params)
      @pagination, @employees = paginate(response, params: page_params)
    end
  end

  # GET /app_services/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = AppServices::EmployeeService.new.get_employee(params[:id])
    end

    def page_params
      { page: params[:page] || 1, per_page: params[:per_page] || PER_PAGE, email: params[:email] }
    end

    def validate_params
      param! :page, Integer, default: 1
      param! :per_page, Integer, default: PER_PAGE
      param! :email, String, required: false, format: URI::MailTo::EMAIL_REGEXP
    end

end

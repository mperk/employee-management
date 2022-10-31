require 'rest-client'

module AppServices
  class EmployeeService

    def get_employee(id)
      response = RestClient.get "https://reqres.in/api/users/#{id}",
                                {content_type: :json, accept: :json }
      return JSON.parse(response.body)["data"]
    end

    def get_employees(params = {})
      default_params = { page: 1, per_page: 6 }
      params = default_params.merge(params)
      return get_request(params)
    end

    # the reqres.in api does not support filter parameter. Therefore we getting all employees
    def get_all_employees
      response = get_request({ page: 1, per_page: 2 })
      if response["total"].present?
        response = get_request({ page: 1, per_page: response["total"].to_i })
      end
      return response
    end

    private

    def get_request(params)
      response = RestClient.get 'https://reqres.in/api/users',
                                {params: {page: params[:page].to_i, per_page: params[:per_page].to_i }, content_type: :json, accept: :json }
      return JSON.parse(response.body)
    end
  end
end


module Pagination
  extend ActiveSupport::Concern
  attr_reader :collection

  def paginate(response, params: {})
    @collection = response["data"]
    params = params.merge(count: response["total"], total_pages: response["total_pages"])
    [
      ViewModel::Pagination.new(params),
      @collection
    ]
  end

end
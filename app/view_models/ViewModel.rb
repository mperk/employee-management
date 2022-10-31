module ViewModel
  class Pagination
    DEFAULT = { page: 1, per_page: 5 }.freeze

    attr_reader :page, :count, :per_page, :total_pages

    def initialize(params = {})
      @page     = (params[:page] || DEFAULT[:page]).to_i
      @count    = params[:count]
      @per_page = params[:per_page] || DEFAULT[:per_page]
      @total_pages = params[:total_pages]
    end

    def next_page
      page + 1 unless last_page?
    end

    def next_page?
      page < total_pages
    end

    def previous_page
      page - 1 unless first_page?
    end

    def previous_page?
      page > 1
    end

    def last_page?
      page == total_pages
    end

    def first_page?
      page == 1
    end

  end
end
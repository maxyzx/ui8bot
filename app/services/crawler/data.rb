module Crawler
  class Data
    attr_reader :page

    def initialize(page)
      @page = page
    end


    CATEGORY_URL = 'https://ui8.net/api/categories/all'.freeze

    def products
      @products ||= JSON.parse(response.body)['data']['products'].select{|b| b['name'] != 'Unlimited Pass'}
    end

    def meta
      @meta ||= JSON.parse(response.body)['data']['meta']
    end

    private
    def response
      @response ||= RestClient.get("#{CATEGORY_URL}?page=#{page}")
    end
  end
end
module Crawler
  class File
    attr_reader :product_id

    def initialize(product_id)
      @product_id = product_id
    end

    PRODUCT_URL = 'https://ui8.net/api/products'.freeze

    def files
      @files ||= JSON.parse(response.body)['data']['product']['paid_files']
    end

    private
    def response
      @response ||= RestClient.get("#{PRODUCT_URL}/#{product_id}", {cookie: cookies})
    end

    def cookies
      @cookies ||= Crawler::Session.new.cookies
    end
  end
end

# Crawler::File.new.files
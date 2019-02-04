module Crawler
  class Sync

    DROPBOX_API = 'https://api.dropboxapi.com/2/files/save_url'.freeze
    DOWNLOAD_URL = 'https://ui8.net/account/download'
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36'.freeze
    ROOT_DICT = 'UI8'

    def run
      product = Product.first

      product_id = product._id
      file_id = product.product_files.first._id
      file_name = product.product_files.first.name

      category = product.category.name

      request_download = RestClient.get("#{DOWNLOAD_URL}/#{product_id}/#{file_id}", {cookie: cookies, user_agent: USER_AGENT})

      link_download = JSON.parse(request_download.body)['signedLink']

      save_dropbox(file_name, category, link_download)
    end

    def save_dropbox(name, category, link)
      params = {
        path: "/#{ROOT_DICT}/#{category}/#{name}",
        url: "https://images.ui8.net/uploads/product-card_1548919497558.jpg"
      }.to_json

      headers = {
        Authorization: "Bearer #{ENV['DROPBOX_TOKEN']}",
        content_type: 'application/json'
      }

      RestClient.post(DROPBOX_API, params, headers) do |response, request, result|
        puts response.body
      end
    end

    def cookies
      @cookies ||= Crawler::Session.new.cookies
    end
  end
end
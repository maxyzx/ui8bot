module Dropbox
  class DropboxService

    attr_reader :file_name, :category, :link

    DROPBOX_API = 'https://api.dropboxapi.com/2/files/save_url'.freeze
    ROOT_DICT = 'UI8'

    def initialize(file_name, category, link)
      @file_name = file_name
      @category = category
      @link = link
    end

    def save_url
      params = {
        path: "/#{ROOT_DICT}/#{category}/#{file_name}",
        url: "https://images.ui8.net/uploads/product-card_1548919497558.jpg"
      }.to_json

      RestClient.post(DROPBOX_API, params, headers) do |response, request, result|
        puts response.body
      end
    end

    private

    def headers
      {
        Authorization: "Bearer #{ENV['DROPBOX_TOKEN']}",
        content_type: 'application/json'
      }
    end
  end
end
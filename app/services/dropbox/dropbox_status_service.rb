module Dropbox
  class DropboxStatusService

    attr_reader :id

    DROPBOX_STATUS_API = 'https://api.dropboxapi.com/2/files/save_url/check_job_status'.freeze
   
    def initialize(id)
      @id = id
    end

    def check
      params = {
        async_job_id: id
      }.to_json
      
      RestClient.post(DROPBOX_STATUS_API, params, headers) do |response, request, result|
        return "{\".tag\": \"failed\", \"failed\": {\".tag\": \"not_found\"}}" unless response.present?
        JSON.parse(response.body)
      end
    end

    private

    def headers
      @headers ||= Dropbox::Token.headers
    end
  end
end

# Dropbox::DropboxStatusService.new("_aPfV5fyxCAAAAAAAAAY4Q").check
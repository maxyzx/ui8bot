module Dropbox
  class DropboxService

    attr_reader :file_name, :category, :link

    DROPBOX_API = 'https://api.dropboxapi.com/2/files/save_url'.freeze
   
    def initialize(file_name, category, link)
      @file_name = file_name
      @category = category
      @link = link
    end

    def save_url
      response_status = nil
      
      params = {
        path: "/#{ENV['ROOT_DICT']}/#{category}/#{file_name}",
        url: link
      }.to_json


      puts "Link download------------------------------------------"        
      puts link
      puts "----------------------------------------------------------"

      RestClient.post(DROPBOX_API, params, headers) do |response, request, result|
        status = "in_progress"

        puts "DROPBOX RESPONSE------------------------------------------"        
        puts response.body
        puts "----------------------------------------------------------"   

        while true
          response_status = Dropbox::DropboxStatusService.new(JSON.parse(response.body)["async_job_id"]).check     
          
          status = response_status[".tag"]
          break if status == "failed" || status == "complete"
          sleep 10
        end
        puts "----------------------------------------------------------"        
        puts response_status
        response_status['.tag'] == "complete"       
      end
      
    end

    private

    def headers
      @headers ||= Dropbox::Token.headers
    end
  end
end

# Dropbox::DropboxService.new("test.zip", "Category Test", "https://s3.amazonaws.com/local-market-frontend-staging/images/Filetest.zip").save_url
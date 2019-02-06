module Dropbox
  class Token

    def self.headers
      {
        Authorization: "Bearer #{ENV['DROPBOX_TOKEN']}",
        content_type: 'application/json'
      }
    end
  end
end
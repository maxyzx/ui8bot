module Crawler
  class Sync

    DOWNLOAD_URL = 'https://ui8.net/account/download'
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36'.freeze
    
    def run
      post_process if sync_dropbox? 
    end

    private



    def sync_dropbox?
      Dropbox::DropboxService.new(file_name, category, link_download).save_url
    end

    def post_process
      product.update(inprogress: true)
      product.product_files.where(name: file[:name]).first.update(download: true)
      if !product.product_files.where(download: false).present?
        product.update(inprogress: false)
        product.update(download: true)
      end
    end

    def link_download
      request_download = RestClient.get("#{DOWNLOAD_URL}/#{product._id}/#{file[:id]}", {cookie: cookies, user_agent: USER_AGENT})
      JSON.parse(request_download.body)['signedLink']
    end

    def file_name
      "#{product.name}/#{file[:name]}"
    end

    def category
      @category ||= product.category.name
    end

    def file
      # TODO: Fixed multiple files
      # files = Crawler::File.new(product.slug).files
      # files.each do |file|
      #   next if download_file?(file)
      #   return {id: file['_id'], name: file['name']}
      # end
      file = Crawler::File.new(product.slug).files.first
      {id: file['_id'], name: file['name']}
    end

    def product
      @product ||= 
        if inprogress_download?
          Product.where(inprogress: true).first
        else
          Product.where(download: false).first
        end
    end

    def download_file?(file)
      download_file = product.product_files.where(name: file['name']).first
      download_file.present? && download_file.download
    end

    def inprogress_download?
      Product.where(inprogress: true).present?
    end

    def cookies
      @cookies ||= Crawler::Session.new.cookies
    end
  end
end
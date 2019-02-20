module Crawler
  class Sync

    DOWNLOAD_URL = 'https://ui8.net/account/download'.freeze
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
      product.product_files.where(name: file.name).first.update(download: true)
      if !product.product_files.where(download: false).present?
        product.update(inprogress: false)
        product.update(download: true)
      end
      product.update(download_at: Time.now)
      send_notification_email product
    end

    def send_notification_email product
      ProductMailer.notify_email(product).deliver
    end

    def link_download
      # "https://s3.amazonaws.com/local-market-frontend-staging/images/Filetest.zip"
      request_download = RestClient.get("#{DOWNLOAD_URL}/#{product._id}/#{file._id}", {cookie: cookies, user_agent: USER_AGENT})
    
      puts "-----------------------------------"
      puts "Crawler::Sync - link_download"
      puts request_download.body
      puts "-----------------------------------"

      JSON.parse(request_download.body)['signedLink']
    
    end

    def file_name
      "#{product.name}/#{file.name}"
    end

    def category
      @category ||= product.category.name
    end

    def file
      product.product_files.each do |file|
        next if file.download
        return file
      end
    end

    def product
      @product ||= 
        if inprogress_download?
          Product.where(inprogress: true).first
        else
          Product.where(download: false).first
        end
    end

    def inprogress_download?
      Product.where(inprogress: true).present?
    end

    def cookies
      @cookies ||= Crawler::Session.new.cookies
    end
  end
end
module Crawler
  class Session
    SIGNIN_URL = 'https://ui8.net/account/signin?json=1'.freeze

    def cookies
      @cookies ||= RestClient.post(SIGNIN_URL, params, {}) do |response, request, result|
        
        puts "-----------------------------------"
        puts "Crawler::Session.cookies"
        puts response.body
        puts "-----------------------------------"

        session_id = response.cookies['ui8.session']
        cookies = "__cfduid=dee8e7671ccb52dbdd36e6113bde7f5131548728347; _csrf=TCRhv5gglXGXYL4owubPJjr1; _ga=GA1.2.1292691169.1548728351; _gid=GA1.2.1041999277.1548728351; __stripe_mid=3617c452-993d-4d03-96b9-78423cbd60ab; intercom-id-lfhojexq=419aa57f-3c5b-4397-8112-c3db42731454; ui8.cart=; ui8_device=s%3Af6e16697dbfc77e0361a27e64ae87fb22ee53788a95684665bbae5795d497dee.19Fm0gswDabJoZJA58GxpLyj6yUZItZvhClQOAHdBhs; __stripe_sid=54e9c5ae-4e93-48b2-9c59-25a8ff875b36;ui8.session=#{session_id}"
      end
    end

    def params
      {
        email: ENV['EMAIL'],
        next: "/",
        password: ENV['PASSWORD'],
      }
    end
  end
end
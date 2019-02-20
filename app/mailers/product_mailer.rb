class ProductMailer < ApplicationMailer
  default from: 'no-reply@ui8bot'

  def notify_email(product)
    @product = product
    mail(to: ENV['NOTIFY_EMAILS'], subject: "[UIBot] New download available")
  end

end
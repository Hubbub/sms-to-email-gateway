require 'sinatra'
require 'twilio-ruby'
require 'json'
require 'pony'

NUMBER_MAP = JSON.parse(ENV["ADDRESSES"])
SMTP_URI = URI.parse(ENV["SMTP_URI"])

Pony.options = {
  from: 'operations@hubbub.co.uk',
  via: :smtp,
  via_options: {
    address: SMTP_URI.hostname,
    port: SMTP_URI.port || 25,
    enable_starttls_auto: true,
    user_name: SMTP_URI.user,
    password: SMTP_URI.password,
    authentication: :plain
  }
}

def send_email(subject, body, to)
  Array(to).each do |address|
    Pony.mail(
      to: address,
      subject: subject,
      body: body
    )
  end
end

post '/sms' do
  unless NUMBER_MAP.key?(params[:To])
    status 422
    body "The number #{params[:To]} has no mappings."
  end

  recipients = NUMBER_MAP[params[:To]]
  send_email("New text message from #{params[:From]}", params[:Body], recipients)

  status 200
  body "Thanks!"
end

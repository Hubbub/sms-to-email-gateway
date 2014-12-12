#!/usr/bin/env ruby
require 'twilio-ruby'
require 'csv'
require 'pry'

twilio = Twilio::REST::Client.new "AC11d35ffa48da41ac9681a505df6966d4", "dcd2fa04234d097447228ea84c51a258"

CSV.foreach(ARGV[0], headers: true) do |row|
  twilio.account.sms.messages.create(
    from: "+44 7903 567542",
    to: row["number"],
    body: "Hello #{row["name"]}, this is a test message."
  )

  $stdout.puts "Messaged #{row["number"]}"
end

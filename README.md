# SMS to Email Gateway

Makes use of Twilio to receive SMS messages, and forward them to email addressees.

## Setup

Push to a Heroku application, and then point a TwiML app at the endpoint https://myapp.herokuapp.com/sms you'll 
then need to configure a mapping between phone numbers and email addresses like so:

```
heroku config:set ADDRESSES='{ "+4412345677": [ "email@example.org", "email2@example.org" ] }'
```

Finally, add an email addon to your Heroku app, or define an SMTP endpoint.

```
heroku config:set SMTP_URI='smtp://user:password@smtp.yourserver.com:25'
```

And you're done!

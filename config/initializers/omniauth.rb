# This file configs the omniauth settings for your app.
# You can add multiple service providers, like: Facebook, Twitter.
# Every provicer has to have a a file/directory in lib/ directory.
# There the magic happens. :) And in controller, of course.

# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = 'Testtt'
APP_SECRET = '123456789'
PROVIDER_URL = 'http://fmi-autentificare.herokuapp.com'
ENV['TWITTER_KEY'] = 'anu7DBFNm55DmPZIXDs4A'
ENV['TWITTER_SECRET'] = 'LpqilJJbbmG9YeWJ63tv1TJZpjbQnOmpiO4GZ7lvSg'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :autentificare, APP_ID, APP_SECRET
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end

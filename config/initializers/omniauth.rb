# This file configs the omniauth settings for your app.
# You can add multiple service providers, like: Facebook, Twitter.
# Every provicer has to have a a file/directory in lib/ directory.
# There the magic happens. :) And in controller, of course.

# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = 'Testtt'
APP_SECRET = '123456789'
PROVIDER_URL = 'http://fmi-autentificare.herokuapp.com'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :autentificare, APP_ID, APP_SECRET
end

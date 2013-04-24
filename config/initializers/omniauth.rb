# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = '0e993ba8-5325-4ba7-9c31-cadcd9955ad3'
APP_SECRET = 'fd5d5ba3fb2e156855a1327cea305b4559adeeff93214bfae1'

CUSTOM_PROVIDER_URL = 'http://fmi-autentificare.herokuapp.com'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :autentificare, APP_ID, APP_SECRET
end
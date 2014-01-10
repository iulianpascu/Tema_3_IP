# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = '4050c5b1-60e0-4822-94c6-3c85bc3e2df6'
APP_SECRET = '5e07a8ae5fda4a610549fb21d6a1d056b24de9ba7dbf10a00e'

CUSTOM_PROVIDER_URL = 'http://app.fmi.unibuc.ro/RepoID'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :autentificare, APP_ID, APP_SECRET
end

require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class Autentificare < OmniAuth::Strategies::OAuth2

      PROVIDER_URL = 'http://fmi-autentificare.herokuapp.com'

      option :client_options, {
        :site =>  PROVIDER_URL,
        :authorize_url => "#{PROVIDER_URL}/auth/autentificare/authorize",
        :access_token_url => "#{PROVIDER_URL}/auth/autentificare/access_token"
      }

      uid { raw_info['id'] }

      def raw_info
        @raw_info ||= access_token.get("/auth/autentificare/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end

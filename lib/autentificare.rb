require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class Autentificare < OmniAuth::Strategies::OAuth2

      CUSTOM_PROVIDER_URL = 'http://fmi-autentificare.herokuapp.com'

      option :client_options, {
          :site =>  CUSTOM_PROVIDER_URL,
          :authorize_url => "#{CUSTOM_PROVIDER_URL}/auth/autentificare/authorize",
          :access_token_url => "#{CUSTOM_PROVIDER_URL}/auth/autentificare/access_token"
      }

      uid { raw_info['id'] }

      # info do
      #   {
      #       :email => raw_info['email']
      #   }
      # end

      extra do
        {
            :first_name => raw_info['extra']['first_name'],
            :last_name  => raw_info['extra']['last_name'],
            :email => raw_info['extra']['email'],
            :student  => raw_info['extra']['student'],
            :teacher => raw_info['extra']['teacher'],
            :management  => raw_info['extra']['management'],
            :admin => raw_info['extra']['admin']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/autentificare/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
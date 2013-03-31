class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  helper_method :token_logged

  private

  def token_logged
    session[:user_token]
  end
end

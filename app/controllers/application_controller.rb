class ApplicationController < ActionController::Base
  protect_from_forgery
  #include SessionsHelper

  def signed_login_required
    redirect_to '/auth/autentificare' unless fmi_logged
  end

  def token_login_required
    session[:user_signed] = nil if fmi_logged
    redirect_to 'token_sign_out' unless token_logged
  end

  def profesor_required
    flash[:notice] = "Doar profesorii au acces la aceasta pagina" unless session[:user_signed]["profesor"]
  end

  helper_method :token_logged
  helper_method :fmi_logged


  private

  def token_logged
    session[:user_token]
  end

  def fmi_logged
    session[:user_signed]
  end

  def retrive_user_role
    require 'net/http'
    require 'json'

  end
end

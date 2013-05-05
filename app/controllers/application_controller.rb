class ApplicationController < ActionController::Base
  protect_from_forgery
  #include SessionsHelper

  def signed_login_required
    redirect_to homepage_path unless fmi_logged
  end

  def token_login_required
    redirect_to homepage_path unless token_logged
  end

  def profesor_required
    unless session[:user_signed][:role] == 'teacher'
      flash[:notice] = "Doar profesorii au acces la acea pagina" 
      redirect_to homepage_path
    end
  end

  def admin_required
    unless session[:user_signed][:role] == 'admin'
      flash[:notice] = "Doar administratorul are acces la acea pagina" 
      redirect_to homepage_path
    end
  end

  def token_logged
    session[:user_token] and IncognitoUser.find_by_token session[:user_token][:token]
  end

  # protected

  def fmi_logged
    session[:user_signed]
  end

  def semestru_curent_hash
    { an: (Date.today.year - (Date.today.month > 6 ? 0 : 1)), 
      semestru: ((Date.today.month > 6) ? 1 : 2) }
  end

  def an_universitar_curent 
    Date.today.year - (Date.today.month > 6 ? 0 : 1)
  end

  def semestru_curent
    Date.today.month > 6 ? 1 : 2
  end
end

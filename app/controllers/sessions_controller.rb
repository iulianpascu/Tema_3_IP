class SessionsController < ApplicationController

  before_filter :signed_login_required, only: [:abort_signed_session, :redirect_to_asigned]
  before_filter :token_login_required, only: [:abort_token_session]

  def redirect_to_asigned
    unless session[:user_signed]["role"]

      require 'net/http'
      require 'json'
      user_url = URI.parse("http://fmi-autentificare.herokuapp.com/users/#{session[:user_signed][:uid].to_i}.json")
      response = Net::HTTP.get_response(user_url)
      user = JSON.load response.body

      session[:user_signed]["role"] = case
                                      when user["student"] then "student"
                                      when user["profesor"] then "profesor"
                                      when user["administrator"] then "administrator"
      end                             else user
    end

    case session[:user_signed]["role"]
    when "student"
      redirect_to homepage_student_path
    when "profesor"
      redirect_to homepage_profesor_path
    when "administrator"
      redirect_to homepage_admin_path
    else
      flash[:notice] = session[:user_signed]["role"].to_s
      #abort_signed_session
    end
  end

  def new
  end

  def create
    if IncognitoUser.find_by_token(params[:sessions][:token])
      session[:user_token] = params[:sessions][:token]

      sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token])
      if sesiune

        if sesiune.incepere_data > Time.now-600
            #redirect_to verificare_path
          flash[:alert] = "Ne pare rau dar proprietarul token-ului este deja logat :D"
          render 'new'
        else

          # redundant
          #sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token])
          #sesiune.destroy
          #SesiuneActiva.create(incognito_user_token: params[:sessions][:token], incepere_data: Time.now)

          sesiune.update_attributes(incepere_data: Time.now)
          redirect_to verificare_path
        end

      else
       SesiuneActiva.create(incognito_user_token: params[:sessions][:token], incepere_data: Time.now)
       redirect_to verificare_path
      end

      #flash[:notice] = "Logatu-te-ai in ceapa ta11!!!!1"
    else
      flash[:notice] = "An account associated with this token doesn't exist"
      render 'new'
    end

  end


  def abort_token_session

    # mai bine lasam in baza, nu incurca pe nimeni
    #sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token])
    #sesiune.destroy

    session[:user_token] = nil

    # deci nu va plac mesajele cu stil
    #flash[:notice] = "Ai iesit cu ochii-n soare"

    redirect_to root_path
  end

  def abort_signed_session
    session[:user_signed] = nil
    redirect_to root_path
  end

  def create_signed
    # raise env["omniauth.auth"].to_yam
    user = { uid: env["omniauth.auth"]["uid"],
             first_name: env["omniauth.auth"]["extra"]["first_name"],
             last_name: env["omniauth.auth"]["extra"]["last_name"]
    }
    session[:user_signed] = user
    redirect_to homepage_path
  end

  def failure
    flash[:notice] = params[:message]
  end

end

class SessionsController < ApplicationController

  before_filter :signed_login_required, only: [:abort_signed_session, :redirect_to_asigned]
  before_filter :token_login_required, only: [:abort_token_session]

  def redirect_to_asigned
    # raise session.to_yaml   

    case session[:user_signed][:role]
    when "student"
      redirect_to homepage_student_path
    when "profesor"
      # require 'net/http'
      # require 'json'
      # user_url = URI.parse("http://fmi-autentificare.herokuapp.com/users/#{session[:user_signed][:uid].to_i}.json")
      # response = Net::HTTP.get_response(user_url)
      # user = JSON.load response.body
      
      redirect_to homepage_profesor_path
    when "administrator"
      redirect_to homepage_admin_path
    else
      flash[:error] = "Rol nesuportat de aplicatie : #{session[:user_signed][:role]}"
      redirect_to sign_out_path
      #abort_signed_session
    end
  # rescue
  #   flash[:error] = 'Ceva neobisnuit s-a petrecut..'
  end

  def new
    redirect_to verificare_path if session[:user_token]
  end

  def create
    if params[:sessions][:token].blank?
      flash[:error] = "Nu te poti loga cu un camp gol!"
      render 'new' and return
    end

    i_user = IncognitoUser.find_by_token params[:sessions][:token].strip
    if i_user
      # mentinem utilizatorul
      session[:user_token] = {token: i_user.token, grupa: i_user.grupa_nume}


      sesiune = SesiuneActiva.find_by_incognito_user_token(i_user.token)
      if sesiune
        if sesiune.incepere_data > Time.now-600
          flash[:error] = "Ne pare rau dar proprietarul token-ului este deja logat :D"
          render 'new'
        else
          sesiune.update_attributes(incepere_data: Time.now)
          redirect_to verificare_path
        end
      else
       SesiuneActiva.create(incognito_user_token: i_user.token, incepere_data: Time.now)
       redirect_to verificare_path
      end

    else
      flash[:error] = "Acel token e invalid.... si eu ma plictisesc"
      render 'new'
    end

  end


  def abort_token_session

    # mai bine lasam in baza, nu incurca pe nimeni
    sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token][:token])
    sesiune.destroy if sesiune

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
    # raise env["omniauth.auth"].to_yaml
    
    session[:user_signed] = { uid: env["omniauth.auth"]["uid"],
                              token: env["omniauth.auth"]['credentials']['token'],
                              first_name: env["omniauth.auth"]["extra"]["first_name"],
                              last_name: env["omniauth.auth"]["extra"]["last_name"],
                              role: case 
                                    when env["omniauth.auth"]["extra"]["student"] then 'student'
                                    when env["omniauth.auth"]["extra"]["teacher"] then 'teacher'
                                    # when env["omniauth.auth"]["extra"]["management"] then 'sef_def'
                                    when env["omniauth.auth"]["extra"]["admin"] then 'admin'
                                    else nil 
                                    end}
    
    redirect_to_asigned
  end

  def failure
    flash[:notice] = params[:message]
  end

end
# 
class SessionsController < ApplicationController

  before_filter :signed_login_required, only: [:abort_signed_session]
  before_filter :token_login_required, only: [:abort_token_session]

  # pagina de login
  def new
    redirect_to_asigned if token_logged or fmi_logged
  end

  # logare prin token pentru evaluarea cursurilor
  def create
    if params[:token].blank?
      flash[:error] = "Nu te poti loga cu un camp gol!"
      render 'new' and return
    end

    i_user = IncognitoUser.find_by_token params[:token].strip
    if i_user
      # verifica daca e perioada de evaluare
      data_eval =  i_user.grupa.data_evaluare.data
      unless Date.today.between? data_eval, data_eval + GossipLogin::DURATA_PERIOADA_EVALUARE - 1
        flash[:error] = "Momentan nu puteti evalua nici un curs"
        render 'new' and return
      end
      
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
      flash[:error] = "Acel token e invalid...."
      render 'new'
    end

  end


  def abort_token_session
    clear_session
    redirect_to root_path
  end

  def abort_signed_session
    clear_session
    redirect_to root_path
  end

  # logare prin FMI-Connect
  def create_signed
    # raise env["omniauth.auth"].to_yaml

    session[:user_signed] = { uid: env["omniauth.auth"]["uid"],
                              token: env["omniauth.auth"]['credentials']['token'],
                              first_name: env["omniauth.auth"]["extra"]["first_name"],
                              last_name: env["omniauth.auth"]["extra"]["last_name"]}
    session[:user_signed][:role] = role_extract(env["omniauth.auth"]["extra"])
    # logger.info env["omniauth.auth"]["extra"]
    # logger.info "ROL :: #{session[:user_signed][:role]}"
    redirect_to_asigned
  end

  # titlu bine ales
  def redirect_to_asigned
    if token_logged
      redirect_to verificare_path
    elsif fmi_logged
      case session[:user_signed][:role]
      when "student" then
        redirect_to homepage_student_path
      when "profesor" then
        redirect_to homepage_profesor_path
      when "admin" then
        redirect_to homepage_admin_path
      else
        flash[:error] = "Rol nesuportat de aplicatie"
        redirect_to sign_out_path
      end
    else
      redirect_to root_path
    end
  end


  # urmeaza metode private
  private

  # pentru ca 
  def role_extract(extra)
    case 
    when extra["student"] && (extra["student"] == true  || extra["student"] == 'true') then 'student'
    when extra["teacher"] && (extra["teacher"] == true  || extra["teacher"] == 'true') then 
      sef_dep = false
      begin
        require 'net/http'
        require 'json'
        user_url = URI.parse("http://fmi-autentificare.herokuapp.com/users/#{session[:user_signed][:uid].to_i}.json?oauth_token=#{session[:user_signed][:token]}")
        response = Net::HTTP.get_response(user_url)
        user = JSON.load response.body
        sef_dep = true if user['user']['teacher']['is_responsable'] == 1
      rescue
        flash[:error] = "Nu am putut determina daca sunteti sef departament"
      ensure
        session[:user_signed][:sef] = sef_dep
      end
      'profesor'
    when extra["admin"] && (extra["admin"] == true  || extra["admin"] == 'true') then 'admin'
    when extra["administrator"] && (extra["administrator"] == true  || extra["administrator"] == 'true') then 'admin'
    else nil
    end
  end

  def clear_session
    if session[:user_token]
      sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token][:token])
      sesiune.destroy if sesiune
      session[:user_token] = nil  
    end

    session[:user_signed] = nil
  end

end
# 
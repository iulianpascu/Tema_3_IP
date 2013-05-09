class ApplicationController < ActionController::Base
  protect_from_forgery
  #include SessionsHelper

  def signed_login_required
    redirect_to_asigned unless fmi_logged
  end

  def token_login_required
    redirect_to_asigned unless token_logged
  end

  def proffesor_required
    unless session[:user_signed][:role] == 'profesor'
      flash[:notice] = "Doar profesorii au acces la acea pagina" 
      redirect_to_asigned
    end
  end

  def admin_required
    unless session[:user_signed][:role] == 'admin'
      flash[:notice] = "Doar administratorul are acces la acea pagina" 
      redirect_to_asigned
    end
  end

  def token_logged
    session[:user_token] and IncognitoUser.find_by_token session[:user_token][:token]
  end

  def fmi_logged
    session[:user_signed]
  end

  def semestru_curent_hash
    { an: (Date.today.year - (Date.today.month > 6 ? 0 : 1)), 
      semestru: ((Date.today.month > 6) ? 1 : 2) }
  end

  helper_method :an_universitar_curent
  def an_universitar_curent 
    Date.today.year - (Date.today.month > 6 ? 0 : 1)
  end

  helper_method :semestru_curent
  def semestru_curent
    Date.today.month > 6 ? 1 : 2
  end

  def load_selection_from_cookie
    if cookies[:selection].blank?
      @selection = {}
    else
      @selection = JSON.load cookies[:selection]
    end

    if params['an']
    end

    %w{an semestru departament tip in_progres}.each do |key|
      @selection[key] = ( params[key] == 'clear' ? nil : params[key] ) if params[key]
    end

    
    cookies[:selection] = @selection.to_json
  end

  protected


  def incarca_cursuri(ops ={})
    select = %q{ SELECT DISTINCT "cursuri"."nume" as denumire, "asocieri"."an",
                 "profesori"."nume" || ' ' || "profesori"."prenume" as profesor, "cursuri"."id" 
                 as id_curs,  "asocieri"."id" as id_eval,
                 "profesori"."departament" as dep, "profesori"."id" as profesor_id
                 FROM cursuri INNER JOIN profesori on "cursuri"."profesor_id" = "profesori"."id" 
                 INNER JOIN asocieri on "cursuri"."id" = "asocieri"."curs_id" where 1 = 1 }
    
    asoc_where = Asociere.where_arguments( an: ops[:an], 
                                           semestru: ops[:semestru] )
    
    if ops[:departament]
      prof_where = Profesor.where_arguments departament: ops[:departament]
    elsif ops[:profesor_id]
      prof_where = Profesor.where_arguments id: ops[:profesor_id]
    end

    where_string = ""
    
    if ops[:in_progres] == 'true'
      where_string << " AND ( asocieri.an = #{an_universitar_curent} AND asocieri.semestru = #{ semestru_curent} AND ( SELECT (data + #{ GossipLogin::perioada_evaluare() -1}) >= '#{Date.today}' FROM data_evaluari INNER JOIN grupe on data_evaluari.grupa_terminal = grupe.terminal WHERE grupe.id = asocieri.grupa_id))"
    else
      where_string << " AND (asocieri.an < #{ an_universitar_curent} OR (asocieri.an = #{ an_universitar_curent} AND asocieri.semestru < #{ semestru_curent} ) OR ( asocieri.an = #{an_universitar_curent} AND asocieri.semestru = #{ semestru_curent} AND ( SELECT (data + #{ GossipLogin::perioada_evaluare() -1}) < '#{Date.today}' FROM data_evaluari INNER JOIN grupe on data_evaluari.grupa_terminal = grupe.terminal WHERE grupe.id = asocieri.grupa_id)))"
    end
    where_string << " AND #{ asoc_where }" unless asoc_where.blank?
    where_string << " AND #{ prof_where }" unless prof_where.blank?
    where_string << " And cursuri.tip like '#{ ops[:tip].first }%' " unless ops[:tip].blank?
    
    @cursuri = Curs.connection.execute "#{ select } #{ where_string };"
  end

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
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  #include SessionsHelper

  def signed_login_required
    redirect_to homepage_path unless fmi_logged
  end

  def token_login_required
    redirect_to homepage_path unless token_logged
  end

  def proffesor_required
    unless session[:user_signed][:role] == 'profesor'
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

    @selection['an'] = params['an'] if params['an']
    @selection['semestru'] = params['semestru'] if params['semestru']
    @selection["departament"] = params['departament'] if params['departament']
    @selection["tip"] = params['tip'] if params['tip']

    
    cookies[:selection] = @selection.to_json
  end

  protected

  def incarca_cursuri(ops ={})
    select = %q{ SELECT DISTINCT "cursuri"."nume" as denumire, "asocieri"."an",
                 "profesori"."nume" || ' ' || "profesori"."prenume" as profesor, "cursuri"."id",
                 "profesori"."departament" as dep, "profesori"."id" as profesor_id
                 FROM cursuri INNER JOIN profesori on "cursuri"."profesor_id" = "profesori"."id" 
                 INNER JOIN asocieri on "cursuri"."id" = "asocieri"."curs_id" 
                 LEFT JOIN grupe on "asocieri"."grupa_id" = "grupe"."id" where 1 = 1 }
    
    asoc_where = Asociere.where_arguments( an: ops[:an], 
                                           semestru: ops[:semestru] )
    
    if ops[:departament]
      prof_where = Profesor.where_arguments departament: ops[:departament]
    elsif ops[:profesor_id]
      prof_where = Profesor.where_arguments id: ops[:profesor_id]
    end

    where_string = ""
    where_string << " AND #{ asoc_where }" unless asoc_where.blank?
    where_string << " AND #{ prof_where }" unless prof_where.blank?
    where_string << " And cursuri.tip like '#{ ops[:tip].first }%' " unless ops[:tip].blank?
    
    @cursuri = Curs.connection.execute "#{ select } #{ where_string };"
  end
end

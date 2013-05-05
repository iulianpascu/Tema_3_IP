class PaginaProfesorController < ApplicationController
  before_filter :signed_login_required
  before_filter :proffesor_required
  before_filter :load_selection_from_cookie
  after_filter :update_cookie


  def pagProfesor
  
    @acces_pdf = true
    

    @ani = []
    Asociere.select(:an).uniq.each { |a| @ani << a.an }

    @selection['an'] = params['an'] if params['an']
    @selection['semestru'] = params['semestru'] if params['semestru']
    
    logger.info @selection

    gr_where = Grupa.where_arguments( specializare: @selection["specializare"], 
                                        an: @selection["an_grupa"], 
                                        serie: @selection["serie"] )

    asoc_where = Asociere.where_arguments( an: @selection["an"], 
                                           semestru: @selection["semestru"] )

    logger.info asoc_where

    where_string = " #{ session[:user_signed][:uid].to_i } " 
    if ( session[:user_signed][:sef] and session[:user_signed][:departament] )
      where_string << " AND \"profesori\".\"departament\" = #{ session[:user_signed][:departament] } "
    end
    where_string << " AND #{ gr_where }" unless gr_where.blank?
    where_string << " AND #{ asoc_where }" unless asoc_where.blank?

    select = %q{ SELECT DISTINCT "cursuri"."nume" as denumire, "asocieri"."an",
                 "profesori"."nume" || ' ' || "profesori"."prenume" as profesor, "cursuri"."id" 
                 FROM cursuri LEFT JOIN profesori on "cursuri"."profesor_id" = "profesori"."id" 
                 INNER JOIN asocieri on "cursuri"."id" = "asocieri"."curs_id" 
                 INNER JOIN grupe on "asocieri"."grupa_id" = "grupe"."id" where "profesori"."id" = }
    query = "#{select} #{where_string};"
    @cursuri = Curs.connection.execute query

    if request.method == "POST"
      
      render 'shared/_lista_cursuri_evaluate', :handler => :erb, :layout => false
    end
	end

end

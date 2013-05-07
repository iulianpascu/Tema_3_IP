class PaginaProfesorController < ApplicationController
  before_filter :signed_login_required
  before_filter :proffesor_required
  before_filter :load_selection_from_cookie

  def pagProfesor
    @acces_pdf = true
    @ani = []
    Asociere.select(:an).uniq.each { |a| @ani << a.an }

    ops = { an: @selection["an"], 
            semestru: @selection["semestru"],
            departament: @selection["departament"],
            tip: @selection['tip'] }
    
    # TODO scos urm 4 randuri
    p = Profesor.find_by_id(session[:user_signed][:uid])
    if session[:user_signed][:sef] 
      session[:user_signed][:departament] = p.departament     
    end
    
    if @selection['doar_personale']
      ops[:profesor_id] = session[:user_signed][:uid].to_i
    end

    incarca_cursuri ops

    if request.method == "POST"
      render 'shared/_lista_cursuri_evaluate', :handler => :erb, :layout => false
    else
      render 'shared/pagina_cursuri', :handler => :erb, :locals => { :pathh => homepage_profesor_path, :show_progress => false  }
    end
	end

end

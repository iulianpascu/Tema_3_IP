class PaginaStudentController < ApplicationController
  before_filter :signed_login_required
  before_filter :load_selection_from_cookie

  def pagStudent
		@acces_pdf = false
    
    @ani = []
    Asociere.select(:an).uniq.each { |a| @ani << a.an }

    incarca_cursuri( an: @selection["an"], 
                     semestru: @selection["semestru"],
                     departament: @selection["departament"],
                     tip: @selection['tip'] )

    if request.method == "POST"
      render 'shared/_lista_cursuri_evaluate', :handler => :erb, :layout => false
    else
      render 'shared/pagina_cursuri', :handler => :erb, :locals => { :pathh => homepage_student_path }
    end
  end
end

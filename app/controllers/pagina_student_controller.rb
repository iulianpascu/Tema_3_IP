class PaginaStudentController < ApplicationController
  before_filter :signed_login_required
  def pagStudent
		@acces_pdf = false
    @specializari = []
    Grupa.select(:specializare).uniq.each { |s| @specializari << s.specializare }
    @serii = []
    Grupa.select(:serie).uniq.each { |s| @serii << s.serie }
    @ani = []
    Asociere.select(:an).uniq.each { |a| @ani << a.an }

    ops = { specializare: params[:spec], 
            an: params[:anul], 
            serie: params[:serie] }

    where_args = Grupa.where_arguments ops
    where_string = "where #{ where_args }" unless where_args.empty?
    select = %q{ SELECT DISTINCT "cursuri"."nume" as denumire, "asocieri"."an",
                 "profesori"."nume" || ' ' || "profesori"."prenume" as profesor, "cursuri"."id" 
                 FROM cursuri LEFT JOIN profesori on "cursuri"."profesor_id" = "profesori"."id" 
                 INNER JOIN asocieri on "cursuri"."id" = "asocieri"."curs_id" 
                 INNER JOIN grupe on "asocieri"."grupa_id" = "grupe"."id" }
    query = "#{select} #{where_string};"
    @cursuri = Curs.connection.execute query
  end
end

class PaginaStudentController < ApplicationController

def pagStudent
				cursuri = Curs.all

		@valori_student =Array.new
			cursuri.each do |c|
				evaluare_disponibila = EvaluareDisponibila.find_by_curs_id(c.id)
				evaluare_completata =
				EvaluareCompletata.find(:all, :conditions =>
				{:evaluare_disponibila_id => evaluare_disponibila.id })
					if evaluare_completata
						@valori_student << c.an
						@valori_student << c.nume
						profesor = Profesor.find_by_id(c.profesor_id)
						@valori_student << profesor.nume
					end
			end

  end
end

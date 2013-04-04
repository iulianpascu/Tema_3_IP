class PaginaProfesorController < ApplicationController

	def pagProfesor

			profesor = Profesor.find_by_id(2)
			@nume_profesor = profesor.nume
			cursuri = Curs.find(:all, :conditions => {:profesor_id => profesor.id})
			if cursuri
					@valori_profesor = Array.new

					cursuri.each do |c|

					evaluare_disponibila = EvaluareDisponibila.find_by_curs_id(c.id)
					evaluare_completata =
					EvaluareCompletata.find(:all, :conditions =>
					{:evaluare_disponibila_id => evaluare_disponibila.id })
						if evaluare_completata
							@valori_profesor << c.an
							@valori_profesor << c.nume
						end

					end

			end
	end

end

class PaginaAdministratorController < ApplicationController

	def pagAdmin
		cursuri = Curs.all

		@valori_admin =Array.new
			cursuri.each do |c|
				evaluare_disponibila = EvaluareDisponibila.find_by_curs_id(c.id)
				evaluare_completata =
				EvaluareCompletata.find(:all, :conditions =>
				{:evaluare_disponibila_id => evaluare_disponibila.id })
					if evaluare_completata
						@valori_admin << c.an
						@valori_admin << c.nume
						profesor = Profesor.find_by_id(c.profesor_id)
						@valori_admin << profesor.nume
					end
			end

	end
end

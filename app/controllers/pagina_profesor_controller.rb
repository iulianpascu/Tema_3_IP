class PaginaProfesorController < ApplicationController

	def pagProfesor

			profesor = Profesor.find_by_id(2)
			@nume_profesor = profesor.nume
			@cursuri = Curs.find(:all, :conditions => {:profesor_id => profesor.id})
			@specializare =Array.new
			@an = Array.new

			@cursuri.each do |c|
				@specializare << c.specializare
			end
			@specializare = @specializare.uniq


			@cursuri.each do |c|
				@an << c.an
			end
			@an = @an.uniq
	end

end

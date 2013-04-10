class PaginaProfesorController < ApplicationController

	def pagProfesor


			profesor = Profesor.find_by_id(2)
			@nume_profesor = profesor.nume
			@cursuri = Curs.find(:all, :conditions => {:profesor_id => profesor.id})
			@param_specializare = params[:spec]
		@param_an = params[:anul]

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



					tmp=0
				if @param_an == "1"
					tmp=1
					#@cursuri = Curs.find(:all, :conditions => {:an => 1})
				elsif  @param_an == "2"
					tmp=2
					#@cursuri = Curs.find(:all, :conditions => {:an => 2})
				elsif  @param_an == "3"
					tmp=3
					#@cursuri = Curs.find(:all, :conditions => {:an => 3})
				elsif @param_an == "4"
					tmp=4
					#@cursuri = Curs.find(:all, :conditions => {:an => 4})
				elsif @param_an == "5"
					tmp=5
					#@cursuri = Curs.find(:all, :conditions => {:an => 5})
				end
				if tmp == 0
					if @param_specializare.eql? "Matematica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica",
								:profesor_id => profesor.id})
					elsif @param_specializare.eql? "Matematica aplicata"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica aplicata",
								:profesor_id => profesor.id})
					elsif @param_specializare.eql? "Matematica informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica informatica",
								:profesor_id => profesor.id})
					elsif @param_specializare.eql? "Informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Informatica",
								:profesor_id => profesor.id})
					elsif @param_specializare.eql? "CTI"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "CTI",
								:profesor_id => profesor.id})
					end
				else
					if @param_specializare.eql? "Matematica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica",
								:an => tmp, :profesor_id => profesor.id})
					elsif @param_specializare.eql? "Matematica aplicata"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica aplicata",
								:an => tmp, :profesor_id => profesor.id})
					elsif @param_specializare.eql? "Matematica informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica informatica",
								:an => tmp, :profesor_id => profesor.id})
					elsif @param_specializare.eql? "Informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Informatica",
								:an => tmp, :profesor_id => profesor.id})
					elsif @param_specializare.eql? "CTI"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "CTI",
								:an => tmp, :profesor_id => profesor.id})
					else
						@cursuri = Curs.find(:all, :conditions => {:an => tmp, :profesor_id => profesor.id})
					end
				end

	end

end

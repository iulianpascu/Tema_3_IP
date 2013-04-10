class PaginaAdministratorController < ApplicationController

	def pagAdmin

		@param_specializare = params[:spec]
		@cursuri= Curs.all
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



		if @param_specializare.eql? "Matematica"
			@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica"})
		elsif @param_specializare.eql? "Matematica aplicata"
			@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica aplicata"})
		elsif @param_specializare.eql? "Matematica informatica"
			@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica informatica"})
		elsif @param_specializare.eql? "Informatica"
			@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Informatica"})
		elsif @param_specializare.eql? "CTI"
			@cursuri = Curs.find(:all, :conditions => {:specializare =>  "CTI"})
		elsif @param_specializare.eql? "all"
			@cursuri = Curs.all
		end


	end
end

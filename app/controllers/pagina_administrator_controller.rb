class PaginaAdministratorController < ApplicationController

	def pagAdmin

		@param_specializare = params[:spec]
		@param_an = params[:anul]
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
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica"})
					elsif @param_specializare.eql? "Matematica aplicata"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica aplicata"})
					elsif @param_specializare.eql? "Matematica informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica informatica"})
					elsif @param_specializare.eql? "Informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Informatica"})
					elsif @param_specializare.eql? "CTI"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "CTI"})
					end
				else
					if @param_specializare.eql? "Matematica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica", :an => tmp})
					elsif @param_specializare.eql? "Matematica aplicata"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica aplicata", :an => tmp})
					elsif @param_specializare.eql? "Matematica informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica informatica", :an => tmp})
					elsif @param_specializare.eql? "Informatica"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "Informatica", :an => tmp})
					elsif @param_specializare.eql? "CTI"
						@cursuri = Curs.find(:all, :conditions => {:specializare =>  "CTI", :an => tmp})
					else
						@cursuri = Curs.find(:all, :conditions => {:an => tmp})
					end
				end


	end



end

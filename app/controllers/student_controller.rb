class StudentController < ApplicationController
  def listare
		@cucu = "string"
  end

  def completare
  end

	def pagStudent
		@cursuri = Curs.all
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

	def cucu
		@cucu = "string"
	end
end

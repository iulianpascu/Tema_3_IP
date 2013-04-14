class EvaluareaCursurilorController < ApplicationController

	require "rexml/document"
	include REXML

	def verificare

		if request.method == "POST"
			flash[:notice] = "Aleluia"
		end
		
		user = IncognitoUser.find_by_token(session[:user_token][:token])
		eval = EvaluareDisponibila.find_all_by_grupa_nume(user.grupa_nume)
		
		@curs = Array.new

		eval.each do |e|
			if e.curs # TODO aici ar tb sa
				@curs << e.curs.nume
				@curs << e.curs.profesor_id
				@curs << e.curs.tip
			end
		end






		doc = Document.new File.new("Chestionar.xml")

		@intrebari_alegeri = Array.new
		@texte_intrebari = Array.new
		@categorii = Array.new
		@intrebari_libere = Array.new

		respond_to do |format|

			doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/enunt_intrebare") do |element|
				@intrebari_alegeri.push element.text
			end



			doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/categorii") do |element|
				@categorii.push element
			end



			doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/texte_intrebari") do |element|
				@texte_intrebari.push element
			end



			doc.elements.each("//chestionar/intrebari_libere/intrebare_libere/enunt_intrebare") do |element|
				@intrebari_libere.push element.text
			end






			format.html # verificare.html.erb
		end




	end

end

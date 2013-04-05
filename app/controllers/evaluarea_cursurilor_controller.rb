class EvaluareaCursurilorController < ApplicationController

require "rexml/document"
		include REXML

	def verificare

#  sesiune = SesiuneActiva.find_by_incognito_user_token(session[:user_token])
#  sesiune = SesiuneActiva.find_by_incognito_user_token("1234")
#		if sesiune
#		flash[:notice] = "Aici"
#			if sesiune.incepere_data > Time.now-600


#  				luam din baza de date numele cursului, numele profesorului si tipul
# 				cursului pentru a completa tabelul :D
					user = IncognitoUser.find_by_token(session[:user_token])
					grupa = Grupa.find_by_nume(user.grupa_nume)
					eval = EvaluareDisponibila.find(:all, :conditions =>
																								{:grupa_nume => grupa.nume})
					@curs = Array.new

					eval.each do |e|
						@curs << e.curs["nume"]
						@curs << e.curs["profesor_id"]
						@curs << e.curs["tip"]
					end






doc = Document.new File.new("Chestionar.xml")

@intrebari_alegeri = Array.new
@texte_intrebari = Array.new
@categorii = Array.new
@intrebari_libere = Array.new
@id_cat = Array.new
@id_intrebare = Array.new
@id_text = Array.new
@intrid = Array.new
@nrcat = Array.new
@nrintr = Array.new
@intrebari_alegeri1 = Array.new



		respond_to do |format|

			doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/
			enunt_intrebare") do |element|
						@intrebari_alegeri.push element.text
			end



			doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/
			categorii") do |element|
						@categorii.push element
			end



			doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/
			texte_intrebari") do |element|
						@texte_intrebari.push element
			end



			doc.elements.each("//chestionar/intrebari_libere/intrebare_libere/
			enunt_intrebare") do |element|
						@intrebari_libere.push element.text
			end


			XPath.each( doc, "//categorie/attribute::id") do |element|
						@id_cat.push element
			end


			XPath.each( doc, "//intrebare_alegeri/attribute::id") do |element|
						@id_intrebare.push element
			end


			XPath.each( doc, "//text_intrebare/attribute::id") do |element|
            @id_text.push element
  		end

      XPath.each( doc, "//intrebare_alegeri/attribute::id") do |element|
            @intrid.push element
			end

 			XPath.each( doc, "//intrebare_alegeri/attribute::nr_cat") do |element|
      			@nrcat.push element
			end

 			XPath.each( doc, "//intrebare_alegeri/attribute::nr_texte") do |element|
            @nrintr.push element
			end



			format.html # verificare.html.erb
		end




	end

end

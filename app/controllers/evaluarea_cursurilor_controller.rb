class EvaluareaCursurilorController < ApplicationController

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



#			else
#				sesiune.destroy
#			end
#		end

	end
end

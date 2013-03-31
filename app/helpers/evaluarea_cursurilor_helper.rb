module EvaluareaCursurilorHelper

	def verificare
		user = IncognitoUser.find_by_token(session[:token])
		grupa = Grupa.find_by_nume(user["grupa_nume"])
		eval = EvaluareDisponibila.find(:all, :conditions =>
																					{:grupa_nume => grupa.nume})
		curs = Array.new

		eval.each do |e|
			curs << e.curs["nume"]
			curs << e.curs["profesor_id"]
			curs << e.curs["tip"]
		end


	end
end

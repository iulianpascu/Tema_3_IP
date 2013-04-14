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
        @curs << {nume: e.curs.nume, 
                  prof: "#{e.curs.profesor.nume} #{e.curs.profesor.prenume}",
                  tip: e.curs.tip,
                  id: e.id,
                  disabled: if EvaluareCompletata.find_by_incognito_user_token_and_evaluare_disponibila_id(user.token, e.id)
                             true
                           else 
                             false
                           end }
      end # if curs
    end # each
  end

end

class EvaluareaCursurilorController < ApplicationController

  def verificare

    if request.method == "POST"
      flash[:notice] = "Aleluiaa!"
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

  def get_chestionar
    require 'json'
    eval = EvaluareDisponibila.find_by_id(params[:id_eval].to_i)
    if eval
      formular = JSON.parse eval.formular.continut 
      @continuturi = formular["chestionar"]
    end
    respond_to do |format|
      format.js
    end
  end

  def post_chestionar
    eval = EvaluareDisponibila.find(params[:id_eval].to_i)
    require 'json'
    if eval
      formular = JSON.load eval.formular.continut 
      @continuturi = formular["chestionar"]
      user = IncognitoUser.find_by_token(session[:user_token][:token])
    else
      flash[:error] = "no eval :("
    end
    respond_to do |format|
      format.js
    end
  end
end

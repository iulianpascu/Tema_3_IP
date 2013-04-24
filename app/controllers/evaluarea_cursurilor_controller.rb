class EvaluareaCursurilorController < ApplicationController

  def verificare

    if request.method == "POST"
      flash[:notice] = "Aleluiaa!"
    end

    user = IncognitoUser.find_by_token(session[:user_token][:token])
    redirect_to token_sign_out_path unless user != nil



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
    # vefic ca evaluarea sa existe si sa fie diponibila grupei utilizatorului
    eval = EvaluareDisponibila.find_by_id_and_grupa_nume(params[:id_eval].to_i, session[:user_token][:grupa])

    # verific daca a completat deja aceasta evaluare
    if eval && !EvaluareCompletata.find_by_incognito_user_token_and_evaluare_disponibila_id(session[:user_token][:token], params[:id_eval].to_i)
      formular = JSON.parse eval.formular.continut 
      @continuturi = formular["chestionar"]
      @eval_id = params[:id_eval].to_i
    else
      flash[:error] = "Acea evaluare nu iti este disponibila, poate ai completat-o deja"
    end
    respond_to do |format|
      format.js
    end
  end

  def post_chestionar
    eval = EvaluareDisponibila.find_by_id_and_grupa_nume(params[:id_eval].to_i, session[:user_token][:grupa])
    comp = EvaluareCompletata.find_by_incognito_user_token_and_evaluare_disponibila_id(session[:user_token][:token], params[:id_eval].to_i)
    # verific daca a completat deja aceasta evaluare
    if eval && !comp
      formular = JSON.parse eval.formular.continut 
      continuturi = formular["chestionar"]
      indecsi_raspunsuri = []
      continuturi.each_with_index do |parent, qindex|
        indecsi_raspunsuri << qindex + 1 if parent["intrebare"]
      end
      raspunsuri = {}
      indecsi_raspunsuri.each {|i| raspunsuri[i.to_s] = params[i.to_s]}
      EvaluareCompletata.create(incognito_user_token: session[:user_token][:token],
                                evaluare_disponibila_id: params[:id_eval],
                                continut: raspunsuri,
                                timp: params[:tpcp])

    else
      flash[:error] = "Acea evaluare nu iti este disponibila, poate ai completat-o deja"
    end
    respond_to do |format|
      format.js
    end
  end
end

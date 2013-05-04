class EvaluareaCursurilorController < ApplicationController
  before_filter :token_login_required
  
  def verificare

    # if request.method == "POST"
    #   flash[:notice] = "Aleluiaa!"
    # end

    user = IncognitoUser.find_by_token(session[:user_token][:token])
    unless user
      redirect_to token_sign_out_path and return
    end

    gr = Grupa.find_by_nume(user.grupa_nume)
    unless gr
      redirect_to token_sign_out_path and return
    end
    eval = gr.asocieri
    
    @curs = Array.new

    eval.each do |e|
      @curs << {nume: e.curs.nume, 
                prof: "#{e.curs.profesor.nume} #{e.curs.profesor.prenume}",
                tip: e.curs.tip,
                id: e.curs.id,
                disabled: if EvalCompletata.find_by_incognito_user_token_and_curs_id(user.token, e.curs.id)
                           true
                         else 
                           false
                         end }
    end # each
  end

  def get_chestionar
    require 'json'
    # vefic ca evaluarea sa existe si sa fie diponibila grupei utilizatorului
    eval = Curs.joins(:grupa).where( "grupe.nume" => session[:user_token][:grupa], 
                                     "cursuri.id" => params[:id_eval].to_i).first

    # eval = EvalDisponibila.find_by_id_and_grupa_nume(params[:id_eval].to_i, session[:user_token][:grupa])

    # verific daca a completat deja aceasta evaluare
    if eval && !EvalCompletata.find_by_incognito_user_token_and_curs_id(session[:user_token][:token], params[:id_eval].to_i)
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
    # eval = EvalDisponibila.find_by_id_and_grupa_nume(params[:id_eval].to_i, session[:user_token][:grupa])
    eval = Curs.joins(:grupa).where( "grupe.nume" => session[:user_token][:grupa], 
                                     "cursuri.id" => params[:id_eval].to_i).first
    comp = EvalCompletata.find_by_incognito_user_token_and_curs_id(session[:user_token][:token], params[:id_eval].to_i)
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
      EvalCompletata.create(incognito_user_token: session[:user_token][:token],
                                curs_id: params[:id_eval],
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

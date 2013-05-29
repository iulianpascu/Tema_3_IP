class EvaluareaCursurilorController < ApplicationController
  before_filter :token_login_required
  before_filter do |controller|

  end
  def verificare
    user = IncognitoUser.find_by_token(session[:user_token][:token])
    unless user
      redirect_to token_sign_out_path and return
    end

    gr = Grupa.find_by_nume(user.grupa_nume)
    unless gr
      redirect_to token_sign_out_path and return
    end
    cursuri = Asociere.joins(:grupa, :curs).where( asocieri: semestru_curent_hash, grupe: {id: gr.id}).order("cursuri.nume ASC")
    
    @curs = []

    cursuri.each do |e|
      c = e.curs
      @curs << {nume: c.nume, 
                prof: "#{c.profesor.nume} #{c.profesor.prenume}",
                tip: c.tip,
                id: e.id,
                disabled: if EvalCompletata.find_by_incognito_user_token_and_curs_id(user.token, e.id)
                           true
                         else 
                           false
                         end }
    end
  end

  def get_chestionar
    require 'json'
    # vefic ca evaluarea sa existe si sa fie diponibila grupei utilizatorului
    gr = Grupa.find_by_nume session[:user_token][:grupa].to_i

    asoc = Asociere.where( an: an_universitar_curent,
                           semestru: semestru_curent,
                           grupa_id: gr.id,
                           id: params[:id_curs].to_i ).first if gr


    # verific daca a completat deja aceasta evaluare
    if asoc && !EvalCompletata.find_by_incognito_user_token_and_curs_id(session[:user_token][:token], params[:id_curs].to_i)
      formular = JSON.parse asoc.formular.continut 
      @continuturi = formular["chestionar"]
      @id_curs = params[:id_curs].to_i
    else
      flash[:error] = "Acea evaluare nu iti este disponibila, poate ai completat-o deja"
    end
    respond_to do |format|
      format.js
    end
  end

  def post_chestionar
    # eval = EvalDisponibila.find_by_id_and_grupa_nume(params[:id_curs].to_i, session[:user_token][:grupa])
    gr = Grupa.find_by_nume session[:user_token][:grupa].to_i

    asoc = Asociere.where( an: an_universitar_curent,
                           semestru: semestru_curent,
                           grupa_id: gr.id,
                           id: params[:id_curs].to_i ).first if gr

    comp = EvalCompletata.find_by_incognito_user_token_and_curs_id(session[:user_token][:token], params[:id_curs].to_i)
    # verific daca a completat deja aceasta evaluare
    if asoc && !comp
      formular = JSON.parse asoc.formular.continut 
      continuturi = formular["chestionar"]
      @necompletate = false
      nc = []
      raspunsuri = {}
      continuturi.each_with_index do |parent, qindex|
        intrebare = parent["intrebare"]
        if intrebare
          key = "#{ qindex + 1 }"
          if params[key] == '0' and intrebare.count > 1
            logger.info "#{qindex} #{intrebare.count} #{intrebare}"
            @necompletate = true 
            nc << {(qindex).to_s => "EMPTY"}
          else
            raspunsuri[key] = params[key].nil? ? '' : params[key].strip
          end
        else
          nc << {(qindex).to_s => "label"}
        end
      end
      
      logger.info nc



      EvalCompletata.create(incognito_user_token: session[:user_token][:token],
                            curs_id: asoc.curs_id,
                            an: asoc.an,
                            semestru: asoc.semestru,
                            continut: raspunsuri,
                            timp: params[:tpcp]) unless @necompletate
    else
      flash[:error] = "Acea evaluare nu iti este disponibila, poate ai completat-o deja"
    end
    respond_to do |format|
      format.js
    end
  end


end

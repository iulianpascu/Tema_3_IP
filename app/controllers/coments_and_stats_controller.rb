class ComentsAndStatsController < ApplicationController
  before_filter :signed_login_required
  before_filter :valid_id
  before_filter :has_rights, only: [:get_coments]

  def get_stats
    require 'json'
    
    if @asociere
      formular = JSON.parse asoc.formular.continut 
      @continuturi = formular["chestionar"]
    else
      flash[:error] = "Curs nedisponibil"
    end
    respond_to do |format|
      format.js
    end
  end

  def get_coments
    respond_to do |format|
      format.pdf do
        pdf = @aproved ? PdfComentarii.new() : PdfErr.new()
        send_data pdf.render, filename: @aproved ? 
          "#{@asociere.curs.nume}-#{@asociere.curs.id}.pdf" : 'eroare',
        type: "application/pdf"
        #disposition: "inline"
      end
    end
  end

  private
  def valid_id
    @asociere = Asociere.find_by_id params[:id]
  end

  def has_rights
    return unless @asociere
    if session[:user_signed][:role] == 'profesor'
      p = Profesor.find_by_id session[:user_signed][:uid]
      cp = @asociere.curs.profesor
      if p.id == cp.id
        @aproved = true
      elsif session[:user_signed][:sef] && p.departament == cp.departament
        @aproved = true
      else
        @aproved = false
      end
    elsif session[:user_signed][:role] == 'admin'
      @aproved = true
    else  
      @aproved = false 
    end
  # rescue
  #   flash[:error] = "a aparut o eroare cu cererea dumneavoastra"
  end
end

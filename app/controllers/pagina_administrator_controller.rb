class PaginaAdministratorController < ApplicationController

  def pagAdmin

    @param_specializare = params[:spec]
    @param_an = params[:anul]
    @cursuri= Curs.all
    @specializare =Array.new
    @an = Array.new
    @cursuri.each do |c|
      @specializare << c.specializare
    end
    @specializare = @specializare.uniq


    @cursuri.each do |c|
      @an << c.an
    end
    @an = @an.uniq



    tmp=0
    if @param_an == "1"
      tmp=1
          #@cursuri = Curs.find(:all, :conditions => {:an => 1})
    elsif  @param_an == "2"
      tmp=2
      #@cursuri = Curs.find(:all, :conditions => {:an => 2})
    elsif  @param_an == "3"
      tmp=3
      #@cursuri = Curs.find(:all, :conditions => {:an => 3})
    elsif @param_an == "4"
      tmp=4
      #@cursuri = Curs.find(:all, :conditions => {:an => 4})
    elsif @param_an == "5"
      tmp=5
      #@cursuri = Curs.find(:all, :conditions => {:an => 5})
    end
    if tmp == 0
      if @param_specializare.eql? "Matematica"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica"})
      elsif @param_specializare.eql? "Matematica aplicata"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica aplicata"})
      elsif @param_specializare.eql? "Matematica informatica"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica informatica"})
      elsif @param_specializare.eql? "Informatica"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Informatica"})
      elsif @param_specializare.eql? "CTI"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "CTI"})
      end
    else
      if @param_specializare.eql? "Matematica"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica", :an => tmp})
      elsif @param_specializare.eql? "Matematica aplicata"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica aplicata", :an => tmp})
      elsif @param_specializare.eql? "Matematica informatica"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Matematica informatica", :an => tmp})
      elsif @param_specializare.eql? "Informatica"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "Informatica", :an => tmp})
      elsif @param_specializare.eql? "CTI"
        @cursuri = Curs.find(:all, :conditions => {:specializare =>  "CTI", :an => tmp})
      else
        @cursuri = Curs.find(:all, :conditions => {:an => tmp})
      end
    end


  end

  def setare_resetare

    if request.method == "POST"
      
      reset_db   = params[:resetare] 
      chestionar = params["chestionar"]
      data_norm  = params[:datepicker]
      data_term  = params[:datepicker2]

      if chestionar
        Formular.create continut: convert_as_hash(chestionar)
      end

      if reset_db
        Profesor.destroy_all
        Curs.destroy_all
        EvaluareDisponibila.destroy_all
      end

      # mai tb verificat daca exista un ultim formular si aruncat msg custom de err
      @id_formular = Formular.last.id
      
      retrive_and_load_groups
      retrive_and_load_courses
    end

  end

  private


  def convert_as_hash(chestionar)
    file = chestionar.read
    j = JSON.load file
  end

  def retrive_and_load_groups
    require 'net/http'
    url = URI.parse("http://coursemanager.herokuapp.com/api/groups/students_number.json")
    response = Net::HTTP.post_form(url, {})
    grupe = JSON.load response.body
    terminal = %w(3 5 8)

    grupe.each do |g|
      Grupa.create(nume:     g["group"].to_s,
                   studenti: g["number"].to_i,
                   terminal: g["group"].at(0).in?(terminal))
    end
  rescue JSON::ParserError
    flash[:error] = "eroare parsare JSON grupe"
  rescue => e
    flash[:error] = "eroare grupe: #{e}"
  end

  def retrive_and_load_courses
    require 'net/http'
    url = URI.parse("http://coursemanager.herokuapp.com/api/teachers/groups.json")
    response = Net::HTTP.post_form(url, {})
    cursuri = JSON.load response.body
    terminal = %w(3 5 8)
    profi = csuri = evals = 0

    cursuri.each do |c|
      unless Profesor.find_by_id c["teacher_id"].to_i
        p         = Profesor.new
        p.nume    = c["teacher_lastname"]
        p.prenume = c["teacher_firstname"]
        p.id      = c["teacher_id"].to_i
        p.save
        profi += 1
      end
      cr = Curs.find_by_nume_and_profesor_id_and_tip(c["course_name"], c["teacher_id"].to_i, c["course_type"])
      unless cr
        cr = Curs.new
        cr.nume         = c["course_name"]
        cr.profesor_id  = c["teacher_id"].to_i  
        cr.tip          = c["course_type"]
        cr.an           = c["group"].at(0).to_i
        cr.save
        csuri += 1
      end
      EvaluareDisponibila.create(curs_id: cr.id,
                                 formular_id: @id_formular,
                                 grupa_nume: c["group"].to_i)
      evals += 1
    end

    a = "au fost bagate in baza #{profi} profi #{csuri} cursuri si #{evals} eval noi"
    flash[:notice] = a
  rescue JSON::ParserError
    flash[:error] = "eroare parsare JSON cursuri"
  # rescue => e
  #   flash[:error] = "eroare cursuri: #{e}"
  end

end

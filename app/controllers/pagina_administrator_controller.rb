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
    xml_to_json('ver.xml')

  end

  def setare_resetare
    @formular = Formular.last
    submit_method if request.method == "POST"
  end

  private
  require 'date'

  def submit_method
    flash[:notice] = []
    flash[:error] = []

    reset_db   = params[:resetare]
    erori = validare_si_mapare

    if erori.any?
      flash[:error] = validare_si_mapare
    else
      if @chestionar
        @formular = Formular.create continut: @chestionar
      end

      # epurez baza
      reset_db ? hard_reset : soft_refresh

      set_start_time
      retrive_and_load_groups
      retrive_and_load_courses
    end
  end

  def validare_si_mapare
    mesaje_validare = []

    # fisier chestionar
    mesaje_validare << "Va rugam specificati un formular" unless @formular or params[:chestionar]
    if params[:chestionar]
      @chestionar = xml_file_to_json_string params[:chestionar]
      mesaje_validare << "Fisierul furnizat nu respecta formatul" unless @chestionar
    end

    # data 1
    if params[:datepicker].blank?
      mesaje_validare << "Data incepere ani neterminali este necesara"
    else
      @data_norm  = parsare_data params[:datepicker]
      mesaje_validare << "Data incepere ani neterminali este gresit formatata" unless @data_norm
    end

    # data 2
    if params[:datepicker2].blank?
      @data_term = @data_norm
    else
      @data_term  = parsare_data params[:datepicker2]
      mesaje_validare << "Data incepere ani terminali este gresit formatata" unless @data_term
    end

    return mesaje_validare
  end

  def parsare_data(data)
    Date.strptime data, '%m/%d/%Y'
  rescue
    nil
  end

  # Incarca noii profesori & grupe fara a sterge pe cei de sem trecut
  def soft_refresh
    EvaluareDisponibila.destroy_all
    IncognitoUser.destroy_all
    DataEvaluare.destroy_all
    SesiuneActiva.destroy_all
  end

  # Suprascrie profesorii & grupele (sterge tot ce apartinea trecutului)
  def hard_reset
    EvaluareDisponibila.destroy_all
    Profesor.destroy_all
    Curs.destroy_all
    Grupa.destroy_all
    IncognitoUser.destroy_all
    DataEvaluare.destroy_all
    SesiuneActiva.destroy_all
  end

  def convert_as_hash(chestionar)
    file = chestionar.read
    j = JSON.load file
  rescue
    nil
  end

  def retrive_and_load_groups
    require 'net/http'
    require 'securerandom'
    url = URI.parse("http://coursemanager.herokuapp.com/api/groups/students_number.json")
    response = Net::HTTP.post_form(url, {})
    grupe = JSON.load response.body
    terminal = %w(3 5 8)

    grupe.each do |g|
      Grupa.create(nume:     g["group"].to_i,
       studenti: g["number"].to_i,
       terminal: g["group"].at(0).in?(terminal))
      (1..(g["number"].to_i)).each do
        rand = SecureRandom.base64(16)
        IncognitoUser.create(grupa_nume: g["group"].to_i,
         token: rand)
      end
    end
  rescue JSON::ParserError
    flash[:error] << "eroare parsare JSON grupe"
  rescue => e
    flash[:error] << "eroare grupe: #{e}"
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
       grupa_nume: c["group"].to_i,
       formular_id: @formular.id)
      evals += 1
    end

    a = "au fost bagate in baza #{profi} profi #{csuri} cursuri si #{evals} eval noi"
    flash[:notice] << "#{profi} profesori noi"
    flash[:notice] << "#{csuri} cursuri noi"
  rescue JSON::ParserError
    flash[:error] = "eroare parsare JSON cursuri"
  # rescue => e
  #   flash[:error] = "eroare cursuri: #{e}"
end

def set_start_time
  DataEvaluare.create data: @data_norm, grupa_terminal: false
  DataEvaluare.create data: @data_term, grupa_terminal: true
end

def xml_file_to_json_string(fisier)
  # require 'json'

  # if not FileTest.exists?(Rails.root + fisier)
  #   flash[:error] = "Fisierul xml nu a fost gasit"
  #   return nil
  # end

  xml = fisier.read
  json = Hash.from_xml(xml).as_json
  flag_error = false
  chestionar=json["chestionar"]
  obiect = Array.new

  if chestionar.class == Hash
    chestionar.each_pair do |chestionar_key,chestionar_value|
      if chestionar_key == "label"
        obiect << {"label" => chestionar_value}
      elsif chestionar_key == "intrebare"
        chestionar_value.each do |intrebare|
          temp = Array.new
          flag =false
          count = 1
          if intrebare.class == Hash
            intrebare.each_pair do |intrebare_key,intrebare_value|

              if count >2
                flash[:error] = "Aveti o eroare in xml#{count}"
                return nil
              end
              if intrebare_key == "enunt"
                flag = true
                if intrebare_value.class == Array
                  flash[:error] = "Aveti o eroare in xml"
                  return nil
                else
                  temp << {"enunt" => intrebare_value}
                end
              else

                if intrebare_key == "rasp" && flag == true
                  if intrebare_value.class == Array
                    intrebare_value.each do |i|
                      temp << {"rasp" => i}
                    end
                  elsif intrebare_value.class == String
                    temp << {"rasp" => intrebare_value}
                  else
                    flash[:error] = "Aveti o eroare in xml"
                    return nil

end #if intrebare_value
else
  flash[:error] = "Aveti o eroare in xml"
  return nil

end # if intrebare_key && flag
end # if intrebare_key
end #intrebare
obiect << {"intrebare" => temp}
else
  flash[:error] = "Aveti o eroare in xml"
  return nil

end #if intrebare
end #chestionar_value
else
  flash[:error] = "Aveti o eroare in xml"
  return nil

end #if chestionar_key

end #chestionar
else
  flash[:error] = "Aveti o eroare in xml. Chestionarul este gol."
  return nil

end #if chestionar

obiect = {"chestionar" => obiect}
@obiect1 = obiect.to_json
return @obiect1
end

end

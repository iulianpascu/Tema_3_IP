class PaginaAdministratorController < ApplicationController
  before_filter :signed_login_required

  def pagAdmin
    @acces_pdf = true
    @specializari = []
    Grupa.select(:specializare).uniq.each { |s| @specializari << s.specializare }
    @serii = []
    Grupa.select(:serie).uniq.each { |s| @serii << s.serie }
    @ani = []
    Asociere.select(:an).uniq.each { |a| @ani << a.an }

    ops = { specializare: params[:spec], 
            an: params[:anul], 
            serie: params[:serie] }

    where_args = Grupa.where_arguments ops
    where_string = "where #{ where_args }" unless where_args.empty?
    select = %q{ SELECT DISTINCT "cursuri"."nume" as denumire, "asocieri"."an",
                 "profesori"."nume" || ' ' || "profesori"."prenume" as profesor, "cursuri"."id" 
                 FROM cursuri LEFT JOIN profesori on "cursuri"."profesor_id" = "profesori"."id" 
                 INNER JOIN asocieri on "cursuri"."id" = "asocieri"."curs_id" 
                 INNER JOIN grupe on "asocieri"."grupa_id" = "grupe"."id" }
    query = "#{select} #{where_string};"
    @cursuri = Curs.connection.execute query
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
      if reset_db
        hard_reset
        set_start_time
        retrive_and_load_groups
        retrive_and_load_courses
      else
        soft_refresh
        set_start_time
        retrive_and_load_groups
      end
      
    end
  end

  def validare_si_mapare
    mesaje_validare = []

    # fisier chestionar
    mesaje_validare << "Va rugam specificati un formular" unless @formular or params[:chestionar]
    unless params[:chestionar].nil? || params[:chestionar].empty?
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

  # Reseteaza Token-uri
  def soft_refresh
    ActiveRecord::Base.transaction do
      IncognitoUser.delete_all
      SesiuneActiva.delete_all
      DataEvaluare.delete_all
      Grupa.delete_all
    end
  end

  # Reseteaza
  # - grupele + token-uri
  # - asocierile grupa-curs-profesor din semestrul curent
  def hard_reset
    ActiveRecord::Base.transaction do
      IncognitoUser.delete_all
      SesiuneActiva.delete_all
      DataEvaluare.delete_all
      Grupa.delete_all
      Asociere.delete_all semestru_curent_hash
    end
  end

  def retrive_and_load_groups
    require 'net/http'
    require 'securerandom'
    
    url = URI.parse("http://coursemanager.herokuapp.com/api/groups/students_number.json")
    response = Net::HTTP.post_form(url, {})
    grupe = Set.new JSON.load response.body
    terminal = %w(3 5 8)

    ActiveRecord::Base.transaction do
      grupe.each do |g|
        
        gr = Grupa.new
        gr.id          = g["group"].to_i
        gr.nume        = g["group"].to_i
        gr.studenti    = g["number"].to_i
        gr.terminal    = g["group"].at(0).in?(terminal)
        # TODO formular dinamic!!!!!
        gr.formular_id = 1
        gr.save

        (1..(g["number"].to_i)).each do
          rand = SecureRandom.base64(16)
          IncognitoUser.create(grupa_nume: g["group"].to_i,
           token: rand)
        end
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
    cursuri = Set.new JSON.load response.body
    terminal = %w(3 5 8)
    profi = csuri = evals = 0

    ActiveRecord::Base.transaction do
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
          cr.nume           = c["course_name"]
          cr.profesor_id    = c["teacher_id"].to_i
          cr.tip            = c["course_type"]
          cr.save
          csuri += 1
        end

        assoc = Asociere.new
        assoc.curs_id  = cr.id
        assoc.grupa_id = c["group"].to_i
        assoc.an       = Utile
        assoc.semestru = Date.today.month > 6 ? 1 : 2
        assoc.save
  
      end
    end

    
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
                elsif intrebare_key == "rasp" && flag == true
                  if intrebare_value.class == Array
                    intrebare_value.each { |i| temp << {"rasp" => i} }
                  elsif intrebare_value.class == String
                    temp << {"rasp" => intrebare_value}
                  else
                    flash[:error] = "Aveti o eroare in xml"
                    return nil
                  end #if intrebare_value
                else
                  flash[:error] = "Aveti o eroare in xml"
                  return nil
                 
                end # if intrebare_key

              end #intrebare.each_pair

            obiect << {"intrebare" => temp}
            else
              flash[:error] = "Aveti o eroare in xml"
              return nil
            end #if intrebare
          end #chestionar_value.each

        else
          flash[:error] = "Aveti o eroare in xml"
          return nil

        end #if chestionar_key

      end #chestionar.each_pair

    else
      flash[:error] = "Aveti o eroare in xml. Chestionarul este gol."
      return nil
    end #if chestionar

    obiect = {"chestionar" => obiect}
    @obiect1 = obiect.to_json
    return @obiect1
  end

end

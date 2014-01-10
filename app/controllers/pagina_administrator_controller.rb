class PaginaAdministratorController < ApplicationController
  before_filter :signed_login_required
  before_filter :admin_required
  before_filter :load_selection_from_cookie


  def pagAdmin
    @acces_pdf = true
    @ani = []
    Asociere.select(:an).uniq.each { |a| @ani << a.an }

    incarca_cursuri( an: @selection['an'], 
     semestru: @selection['semestru'],
     departament: @selection['departament'],
     in_progres: @selection['in_progres'],
     tip: @selection['tip'] )

    if request.method == 'POST'
      render 'shared/_lista_cursuri_evaluate', :handler => :erb, :layout => false
    else
      render 'shared/pagina_cursuri', :handler => :erb, :locals => { :pathh => homepage_admin_path, :show_progress => true }
    end
  end

  def setare_resetare
    @formular = Formular.last
    @error_raised = nil
    submit_method if request.method == 'POST'
  end

  def get_tokens
    term = params[:id] == 'terminal' ? true : false 
    d = DataEvaluare.find_by_grupa_terminal term
    if d
      d.last_refresh = Date.today
      d.save
    else
      DataEvaluare.create(grupa_terminal: term, last_refresh: Date.today)
    end
    generate_tokens(term) 
    pdf = TokensPdf.new(params['id'])
    send_data pdf.render, filename: "Grupe_#{params[:id]}e.pdf", type: 'application/pdf', disposition: 'inline'
    
  end

  private
  require 'date'

  def submit_method
    flash[:notice] = []
    flash[:error] = []

    reset_db   = params[:resetare]
    erori = validare_si_mapare

    if erori.any?
      flash[:error] = erori
    else
      @formular = Formular.create continut: @chestionar if @chestionar
      
      # daca ceva pica, baza nu e compromisa
      ActiveRecord::Base.transaction do
        require 'net/http'  
        Asociere.where( semestru: semestru_curent, an: an_universitar_curent).delete_all
        @profi = @csuri = @nrgr = 0
        if reset_db
          DataEvaluare.delete_all
          set_start_time  
          Grupa.delete_all
          retrive_and_load_groups
          retrive_and_load_teachers
          retrive_and_load_courses # with group assoc
        else
          DataEvaluare.delete_all
          set_start_time
          retrive_and_load_teachers
          retrive_and_load_courses 
        end
      end
    end
  end

  def validare_si_mapare
    mesaje_validare = []

    # fisier chestionar
    mesaje_validare << 'Va rugam specificati un formular' unless @formular or params[:chestionar]
    unless params[:chestionar].nil? 
      begin
        @chestionar = xml_file_to_json_string params[:chestionar]
      ensure
        mesaje_validare << 'Fisierul furnizat nu respecta formatul' unless @chestionar
      end
    end

    # data 1
    if params[:datepicker].blank?
      mesaje_validare << 'Data incepere ani neterminali este necesara'
    else
      @data_norm  = parsare_data params[:datepicker]
      mesaje_validare << 'Data incepere ani neterminali este gresit formatata' unless @data_norm
    end

    # data 2
    if params[:datepicker2].blank?
      @data_term = @data_norm
    else
      @data_term  = parsare_data params[:datepicker2]
      mesaje_validare << 'Data incepere ani terminali este gresit formatata' unless @data_term
    end

    return mesaje_validare
  end

  def parsare_data(data)
    Date.strptime data, '%m/%d/%Y'
  rescue
    nil
  end

  def json_check_for_error(rhash)
    
    if rhash.class == {}.class && rhash['error']
      if rhash['error'] == 'Token expired'
        flash[:error] << 'Sesiunea dumneavoastra a expirat' 
        flash[:notice] << 'Pentru a putea folosi in continuare aplicatia va rugam sa va reautentificati'
        :sign_out
      else
        flash[:error] << 'Aplicatia fmi-autentificare a returnat eroare la request-ul /teacher/departments'
        :warn
      end
    end
  end

  def generate_tokens(term)
    require 'securerandom'
    ActiveRecord::Base.transaction do
      IncognitoUser.in_last_year(term).delete_all
      Grupa.all.each do |g|
        if g.studenti and g.terminal == term
          g.studenti.times do
            rand = SecureRandom.base64(16)
            while IncognitoUser.find_by_token(rand)
              rand = SecureRandom.base64(16)
            end
            IncognitoUser.create(grupa_nume: g.nume, token: rand)
          end
        end
      end
    end
  end

  def retrive_and_load_groups
    # url = URI.parse('http://coursemanager.herokuapp.com/api/groups/students_number.json')
    # response = Net::HTTP.post_form(url, {})
    # rhash = JSON.load response.body
    f = File.open('stud_no.json')
    rhash = JSON.load f.read
    f.close
    
    @error_raised = json_check_for_error rhash
    return if @error_raised

    grupe = Set.new rhash
    grupe.each do |g|

      gr = Grupa.new
      gr.id          = g['group'].to_i
      gr.nume        = g['group'].to_i
      gr.studenti    = g['number'].to_i
      gr.terminal    = g['group'].to_s =~ /^(30|31|32|33|34|50)/ ? true : false
      gr.an          = gr.nume.to_s.at 0
      gr.save
      @nrgr += 1
      # gr.studenti.times do
      #   rand = SecureRandom.base64(16)
      #   IncognitoUser.create(grupa_nume: gr.nume, token: rand)
      # end

    end
  rescue JSON::ParserError
    flash[:error] << 'eroare parsare JSON grupe'
    @error_raised = :warn
  # rescue => e
  #   flash[:error] << 'eroare grupe: #{e}'
  #   @error_raised = :warn
  end

  def retrive_and_load_teachers
    # url = URI.parse('http://fmi-autentificare.herokuapp.com/teacher/departments.json?oauth_token=#{session[:user_signed][:token].to_s}')
    # response = Net::HTTP.post_form(url, {})
    # rhash = JSON.load response.body
    f = File.open('dep.json')
    rhash = JSON.load f.read
    f.close

    @error_raised = json_check_for_error rhash
    return if @error_raised

    rhash.each do |departament, profesori|
      rhash[departament].each do |prof|
        p = Profesor.find_by_id prof['id']
        p = Profesor.new unless p

        p.nume    = prof['last_name']
        p.prenume = prof['first_name']
        p.id      = prof['id'].to_i
        p.departament = departament

        p.save
        @proff += 1
      end
    end



  rescue JSON::ParserError
    flash[:error] << 'eroare parsare JSON profesori'
    @error_raised = :warn
  rescue => e
    flash[:error] << 'eroare profesori: #{e}'
    @error_raised = :warn
  end

  def retrive_and_load_courses
    # url = URI.parse('http://coursemanager.herokuapp.com/api/teachers/groups.json')
    # response = Net::HTTP.post_form(url, {})
    # cursuri = Set.new JSON.load response.body
    f = File.open('grupe.json')
    cursuri = Set.new JSON.load f.read
    f.close

    

    
    cursuri.each do |c|
      unless Profesor.find_by_id c['teacher_id'].to_i
        p         = Profesor.new
        p.nume    = c['teacher_lastname']
        p.prenume = c['teacher_firstname']
        p.id      = c['teacher_id'].to_i
        p.save
        @profi += 1
      end

      cr = Curs.find_by_nume_and_profesor_id_and_tip(c['course_name'], c['teacher_id'].to_i, c['course_type'])
      unless cr
        cr = Curs.new
        cr.nume           = c['course_name']
        cr.profesor_id    = c['teacher_id'].to_i
        cr.tip            = c['course_type']
        cr.save
        @csuri += 1
      end

      assoc = Asociere.where(curs_id: cr.id,
                            grupa_id: c['group'].to_i,
                            an: an_universitar_curent,
                            semestru: semestru_curent).first
      unless assoc
        assoc = Asociere.new 
        assoc.curs_id  = cr.id
        assoc.grupa_id = c['group'].to_i
        assoc.an       = an_universitar_curent 
        assoc.semestru = semestru_curent
      end

      assoc.formular_id = @formular.id
      assoc.save
      

    end

    flash[:notice] << "#{@nrgr} grupe adaugate"
    flash[:notice] << "#{@profi} profesori adaugati"
    flash[:notice] << "#{@csuri} cursuri adaugate"
  rescue JSON::ParserError
    flash[:error] = 'eroare parsare JSON cursuri'
  rescue => e
    flash[:error] = "eroare cursuri: #{e}"
  end

  def set_start_time
    d1 = DataEvaluare.find_by_grupa_terminal false
    if d1
      d1.data = @data_norm
      d1.save
    else
      DataEvaluare.create data: @data_norm, grupa_terminal: false 
    end
    d2 = DataEvaluare.find_by_grupa_terminal false
    if d2
      d2.data = @data_term
      d2.save
    else
      DataEvaluare.create data: @data_term, grupa_terminal: true
    end
  end

  require 'nokogiri'
  require 'json'

  def xml_file_to_json_string(file)
    doc = Nokogiri::XML file.read
    raise 'Tag-ul chestionar nu-i la locul lui' unless doc.child.node_name == 'chestionar'
    chestionar = []
    doc.child.element_children.each do |elem1|
      if elem1.node_name == 'label'
        chestionar << { 'label' => elem1.content }
      elsif elem1.node_name == 'intrebare'
        intrebare = []
        elem1.element_children.each do |elem2|
          case elem2.node_name 
          when 'enunt'
            intrebare << { 'enunt' => elem2.content }
          when 'rasp'
            intrebare << { 'rasp' => elem2.content }
          else
            raise 'Tag necunoscut'
          end
        end
        chestionar << { 'intrebare' => intrebare }
      else
        raise 'Tag necunoscut'
      end
    end
    return { 'chestionar' => chestionar }.to_json
  rescue 
    raise 'Eroare parsare fisier'
  end

end

class PdfComentarii < Prawn::Document

  def initialize(eval_id)
    @eval_id = eval_id
    super()
    generate
  end

  def generate
    if @eval_id
      asoc = Asociere.find_by_id @eval_id
      grupe = Asociere.where( curs_id: asoc.curs_id, semestru: asoc.semestru, an: asoc.an, formular_id: asoc.formular_id).pluck(:grupa_id).join ', '
      an = Date.today.year - (Date.today.month > 9 ? 0 : 1)
      an = "#{an} - #{an + 1}"
      t = Date.today
      semestru  = if 10 <= t.month or t.month <= 1
                    1
                  elsif t.month == 2
                    t.day < 18 ? 1 : 2
                  else
                    2
                  end
      
      begin
        tip = asoc.curs.tip.downcase.at 0
        tip = case 
              when tip == 'c' then 'Curs'
              when tip == 's' then 'Seminar'  
              when tip == 'l' then 'Laborator'    
              end
      rescue
        tip = 'Fara tip'  
      end
      header_text = "#{tip}: #{asoc.curs.nume}\nProfesor: #{asoc.curs.profesor.nume} #{asoc.curs.profesor.prenume}\nGrupe: #{grupe}\nAn: #{an}           Semestru: #{semestru}"

      intrebari = asoc.formular.intrebari_libere
      header_box do
        font('Helvetica', :size => 16) do
          text(header_text, :color  => BROWN, :valign => :center)
        end
      end
      intrebari.each do |intrebare|
        intrebare_box intrebare[:text]
        
        rasp = asoc.obtine_raspunsuri_pt intrebare[:index]
        if rasp.any?
          rasp.each do |raspuns, idx|
            text "     >>    #{raspuns['text']}"
            move_down 20
          end
        else
          text 'nici un raspuns'
        end
      end
      
    else
      text 'Eroare: acest curs nu a putut fi gasit'
    end
  end

  def intrebare_box(txt)
    font('Courier', :size => 11.5) do
      colored_box(
        [{ :text  => txt,
          :color => BLACK }],:fill_color => LIGHT_GOLD)
    end 
  end
  BOX_MARGIN = 36
  RHYTHM = 10
  BLACK      = "000000"
  LIGHT_GRAY = "F2F2F2"
  GRAY       = "DDDDDD"
  DARK_GRAY  = "333333"
  BROWN      = "A4441C"
  ORANGE     = "F28157"
  LIGHT_GOLD = "FBFBBE"
  DARK_GOLD  = "EBE389"
  BLUE       = "0000D0"
  INNER_MARGIN = 30
  LEADING = 2
  def header_box(&block)

    bounding_box([-bounds.absolute_left, cursor + BOX_MARGIN],
     :width  => bounds.absolute_left + bounds.absolute_right,
     :height => BOX_MARGIN*2 + RHYTHM*2) do

      fill_color LIGHT_GRAY
      fill_rectangle([bounds.left, bounds.top],
        bounds.right,
        bounds.top - bounds.bottom)
      fill_color BLACK

      indent(BOX_MARGIN + INNER_MARGIN, &block)
    end

    stroke_color GRAY
    stroke_horizontal_line(-BOX_MARGIN, bounds.width + BOX_MARGIN, :at => cursor)
    stroke_color BLACK

    move_down(RHYTHM*3)
  end

  def inner_box(&block)
    bounding_box([INNER_MARGIN, cursor],
     :width => bounds.width - INNER_MARGIN*2,
     &block)
  end

    # Renders a Bounding Box with some background color and the formatted text
    # inside it
    #
    def colored_box(box_text, options={})
      options = { :fill_color   => DARK_GRAY,
        :stroke_color => nil,
        :text_color   => LIGHT_GRAY,
        :leading      => LEADING
        }.merge(options)

        
        text_options = { :leading        => options[:leading], 
          :fallback_fonts => ["Helvetica", "Kai"]
        }

        box_height = height_of_formatted(box_text, text_options)

        bounding_box([INNER_MARGIN + RHYTHM, cursor],
         :width => bounds.width - (INNER_MARGIN+RHYTHM)*2) do

          fill_color   options[:fill_color]
          stroke_color options[:stroke_color] || options[:fill_color]
          fill_and_stroke_rounded_rectangle(
            [bounds.left - RHYTHM, cursor],
            bounds.left + bounds.right + RHYTHM*2,
            box_height + RHYTHM*2,
            5
            )
          fill_color   BLACK
          stroke_color BLACK

          pad(RHYTHM) do
            formatted_text(box_text, text_options)
          end
        end

        move_down(RHYTHM*2)
      end

    end
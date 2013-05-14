class PdfComentarii < Prawn::Document

  def initialize(eval_id)
    @eval_id = eval_id
    super()
    generate
  end

  def generate
    if @eval_id
      asoc = Asociere.find_by_id @eval_id
      intrebari = asoc.formular.intrebari_libere
      intrebari.each do |intrebare|
        text intrebare[:text]
        rasp = asoc.obtine_raspunsuri_pt intrebare[:index]
        if rasp.any?
          rasp.each do |raspuns|
            text raspuns['text']
          end
        else
          text 'nici un raspuns'
        end
      end
      
    else
      text 'Eroare: acest curs nu a putut fi gasit'
    end
  end

end
class PdfErr < Prawn::Document

  def initialize()
    super()
    generate
  end

  def generate
    text "Nu ai suficiente privilegii pentru a accesa aceste date!"
  end
end
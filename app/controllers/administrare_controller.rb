class AdministrareController < ApplicationController

require "rexml/document"
		include REXML  

  def listare

  end

  def adaugare

			doc = Document.new File.new("Chestionar.xml")
			
@intrebari_alegeri = Array.new
@texte_intrebari = Array.new
@categorii = Array.new
@intrebari_libere = Array.new
@id = Array.new


			respond_to do |format|



							doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/enunt_intrebare") do |element| 
							@intrebari_alegeri.push element.text 

							end




	
							doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/categorii/categorie") do |element| 
							@categorii.push element.text 

							end





					doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/texte_intrebari/text_intrebare") do |element| 
							@texte_intrebari.push element.text 

							end
							
							
							



			
							doc.elements.each("//chestionar/intrebari_libere/intrebare_libere/enunt_intrebare") do |element| 
							@intrebari_libere.push element.text 

							end
							
							
							XPath.each( doc, "//categorie/attribute::id") do |element|  
               				@id.push element
							end
							
							
							
				  format.html # adaugare.html.erb
				end
				
				
  end

  def generare
  
  end
end

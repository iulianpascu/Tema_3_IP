require "rexml/document"
		include REXML  

doc = Document.new File.new("Chestionar.xml")

doc.elements.each("//chestionar/intrebari_alegeri/intrebare_alegeri/enunt_intrebare") do |element| 
			puts element.text 

end

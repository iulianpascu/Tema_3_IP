class UserPdf < Prawn::Document

	def initialize()
		super()
		for i in 1..10 do
			generate
		end
	end

	def generate
		text_box "Grupa", :at => [200,cursor-20]
		move_down 50
		data = [["      Grupa
		12345678910111213141516","12345678910111213141516"]]
		data += [["12345678910111213141516","12345678910111213141516"]] * 15
		table(data, width: 450, :cell_style => {:align=>
		:center, :height => 70,:padding => 5})
		start_new_page
	end
end

class UserPdf < Prawn::Document

	def initialize()
		super()

		generate

	end

	def generate
		grupa = Grupa.all
		grupa.each do |g|
			i_users = IncognitoUser.find_all_by_grupa_nume(g.nume)
			if i_users.any?

				text_box "Grupa #{g.nume} #{i_users.count}", :at => [200,cursor-20]
				move_down 50

				data = []
				
				i_users.each_slice(2) do |a,b|

					cell_1 = make_cell(:content =>"Grupa #{g.nume}\n#{a.token}")
					if b
						cell_2 = make_cell(:content =>"Grupa #{g.nume}\n#{b.token}")
						data << [cell_1,cell_2]
					else
						data << [cell_1]
					end

				end

				# # data += [[cell_1, nil]] if i_users.count % 2 == 1
				
				table(data, :width => 450)#, :cell_style => {:align=> :center, :height => 70,:padding => 15}) 
			end
			start_new_page
		end
	end



#					text_box "Grupa", :at => [200,cursor-20]
#					move_down 50
#					data = [["12345678910111213141516","12345678910111213141516"]]
#					data += [["12345678910111213141516","12345678910111213141516"]] * 15
#					table(data, width: 450, :cell_style => {:align=>
#					:center, :height => 70,:padding => 25})
#					start_new_page
end


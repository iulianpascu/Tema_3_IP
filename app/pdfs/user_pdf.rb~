class UserPdf < Prawn::Document

	def initialize()
		super()

			generate

	end

	def generate
		grupa = Grupa.all
		grupa.each do |g|


			text_box "Grupa #{g.nume}", :at => [200,cursor-20]
			move_down 50

			user=IncognitoUser.find(:all, :conditions =>
																								{:grupa_nume => g.nume})
				data = [[]]
				user = user.to_enum
				user.each do |u|

					cell_1 = make_cell(:content => "Grupa #{g.nume}
					           #{u.token}")
					u = user.next
					cell_2 = make_cell(:content => "Grupa #{g.nume}
					           #{u.token}")

data += [[cell_1,cell_2]]

#					text_box "Grupa", :at => [200,cursor-20]
#					move_down 50
#					data = [["12345678910111213141516","12345678910111213141516"]]
#					data += [["12345678910111213141516","12345678910111213141516"]] * 15
#					table(data, width: 450, :cell_style => {:align=>
#					:center, :height => 70,:padding => 25})
#					start_new_page

				end
				table(data, width: 450, :cell_style => {:align=>
					:center, :height => 70,:padding => 15})
		end

	end
end

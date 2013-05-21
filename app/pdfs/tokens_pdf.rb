class TokensPdf < Prawn::Document

  def initialize(t)
    super()
    @terminal = (t == 'terminal')
    generate
  end

  def generate
    grupe = Grupa.where terminal: @terminal 
    grupe.each do |g|
      i_users = IncognitoUser.where grupa_nume: g.nume
      if i_users.any?

        text_box "Grupa #{g.nume} #{i_users.count}", :at => [200,cursor-20]
        move_down 50

        data = []
        
        i_users.each_slice(2) do |a,b|

          cell_1 = make_cell(:content =>"Grupa #{g.nume}\n#{a.token}\n#{Date.today}")
          if b
            cell_2 = make_cell(:content =>"Grupa #{g.nume}\n#{b.token}\n#{Date.today}")
            data << [cell_1,cell_2]
          else
            data << [cell_1]
          end

        end

        # # data += [[cell_1, nil]] if i_users.count % 2 == 1
        
        table(data, :width => 450)#, :cell_style => {:align=> :center, :height => 70,:padding => 15}) 
        start_new_page
      end
      
    end
  end


end


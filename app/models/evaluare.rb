class Evaluare < ActiveRecord::Base
  attr_accessible :an_terminal, :grupa, :id_curs, :id_prof

  belongs_to :grupas
  belongs_to :profesors
  belongs_to :curs

end

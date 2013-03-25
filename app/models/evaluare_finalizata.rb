class EvaluareFinalizata < ActiveRecord::Base
  attr_accessible :data_completare, :detalii, :durata, :grupa, :id_curs, :id_prof, :token

  belongs_to :curs
  belongs_to :profesors
  belongs_to :evaluare_in_progres
end

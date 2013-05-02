class EvalDisponibila < ActiveRecord::Base
  attr_accessible :curs_id, :formular_id, :grupa_nume
  belongs_to :curs
  belongs_to :formular
  belongs_to :grupa
  has_many :evaluare_completate
end

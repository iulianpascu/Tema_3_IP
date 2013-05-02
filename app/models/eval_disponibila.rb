class EvalDisponibila < ActiveRecord::Base
  attr_accessible :curs_id, :formular_id, :grupa_nume, :semestru
  belongs_to :curs
  belongs_to :formular
  belongs_to :grupa
  has_many :eval_completate
end

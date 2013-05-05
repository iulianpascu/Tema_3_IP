class Asociere < ActiveRecord::Base
  attr_accessible :an, :curs_id, :formular_id, :grupa_id, :semestru
  belongs_to :curs, :inverse_of => :asocieri
  belongs_to :grupa, :inverse_of => :asocieri
  belongs_to :formular, :inverse_of => :asocieri
  has_many :eval_completate, :inverse_of => :asociere

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
  
end

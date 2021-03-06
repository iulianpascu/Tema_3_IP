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
  
  def atribuie_formular_id
    raise 'nu pot determina formular_id fara grupa_id' unless self.grupa_id
    g = Grupa.find_by_id self.grupa_id
    raise 'nu pot determina formular_id: grupa_id nu referentiaza o grupa valida' unless g
    raise 'NEIMPLEMENTAT inca..'
    self.formular_id = 102
  end

  def obtine_raspunsuri_pt(qindex)
    query = "select continut -> '#{qindex}' as text from eval_completate where curs_id = #{self.curs_id} and semestru = #{self.semestru} and an = #{self.an} and not continut @> hstore('#{qindex}', '');"
    self.connection.execute query
  end
end

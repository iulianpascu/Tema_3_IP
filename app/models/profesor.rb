class Profesor < ActiveRecord::Base
  attr_accessible :nume, :prenume, :departament
  has_many :cursuri

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
end

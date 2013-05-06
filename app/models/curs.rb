class Curs < ActiveRecord::Base
  attr_accessible :nume, :profesor_id, :tip
  belongs_to :profesor, :inverse_of => :cursuri
  has_many :asocieri, :inverse_of => :curs
  has_many :eval_completate, :through => :asocieri
  has_many :grupe, :through => :asocieri

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
end

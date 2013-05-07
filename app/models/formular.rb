class Formular < ActiveRecord::Base
  attr_accessible :continut
  has_many :asocieri

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
end

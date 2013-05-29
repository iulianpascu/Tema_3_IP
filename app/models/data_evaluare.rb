class DataEvaluare < ActiveRecord::Base
  attr_accessible :data, :grupa_terminal, :last_refresh
  has_many :grupe, { :primary_key => 'grupa_terminal', 
                     :foreign_key => 'terminal'}

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
end

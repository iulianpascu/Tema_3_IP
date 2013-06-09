class IncognitoUser < ActiveRecord::Base
  attr_accessible :grupa_nume, :token
  belongs_to :grupa, { :primary_key => 'nume', 
                       :foreign_key => 'grupa_nume', 
                       :inverse_of => :incognito_users }
  has_one :sesiune_activa
  has_many :eval_completate

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end

  scope :in_last_year, lambda { |term|  where("grupa_nume IN (#{select("grupa_nume").joins(:grupa).where("grupe.terminal = ?").to_sql})", term)
  }
end

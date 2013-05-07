class Grupa < ActiveRecord::Base
  attr_accessible :nume, :studenti, :terminal, :an, :serie, :specializare,  :domeniu
  belongs_to :data_evaluare, { :primary_key => 'grupa_terminal',
                               :foreign_key => 'terminal' }
  has_many :incognito_users, { :primary_key => 'nume',
                               :foreign_key => 'grupa_nume',
                               :inverse_of => :grupa }
  has_many :asocieri, :inverse_of => :grupa
  has_many :cursuri, :through => :asocieri


  def self.cauta(options = {})
    self.where self.where_arguments options
  end

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
end

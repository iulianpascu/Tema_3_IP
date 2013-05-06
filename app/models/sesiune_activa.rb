class SesiuneActiva < ActiveRecord::Base
  attr_accessible :incepere_data, :incognito_user_token
  belongs_to :incognito_user

	validates_uniqueness_of :incognito_user_token

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
end

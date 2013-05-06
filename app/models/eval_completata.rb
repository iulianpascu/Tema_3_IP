class EvalCompletata < ActiveRecord::Base
  attr_accessible :continut, :curs_id, :incognito_user_token, :timp, :data
  serialize :continut, ActiveRecord::Coders::Hstore
  belongs_to :incognito_user, { :primary_key => 'token', 
                                :foreign_key => 'incognito_user_token', 
                                :inverse_of => :eval_completate }
  belongs_to :asociere, :inverse_of => :eval_completate
  belongs_to :curs

  def self.where_arguments(options = {})
    options.delete_if { |k, val| val == nil }
    self.sanitize_sql_hash_for_conditions options
  end
end

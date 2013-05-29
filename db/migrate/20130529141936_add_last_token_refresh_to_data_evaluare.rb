class AddLastTokenRefreshToDataEvaluare < ActiveRecord::Migration
  def change
    add_column :data_evaluari, :last_refresh, :date
  end
end

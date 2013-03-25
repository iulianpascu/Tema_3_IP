class CreateDataEvaluares < ActiveRecord::Migration
  def change
    create_table :data_evaluares do |t|
      t.boolean :an_terminal
      t.datetime :data_start
      t.datetime :data_stop

      t.timestamps
    end
  end
end

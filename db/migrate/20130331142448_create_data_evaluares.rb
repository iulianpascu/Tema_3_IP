class CreateDataEvaluares < ActiveRecord::Migration
  def change
    create_table :data_evaluari do |t|
      t.boolean :grupa_terminal
      t.date :data

      # t.timestamps
    end
  end
end

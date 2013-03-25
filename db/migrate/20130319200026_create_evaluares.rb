class CreateEvaluares < ActiveRecord::Migration
  def change
    create_table :evaluares do |t|
      t.integer :id_curs
      t.integer :id_prof
      t.string :grupa
      t.boolean :an_terminal

      t.timestamps
    end
  end
end

class CreateEvaluareFinalizata < ActiveRecord::Migration
  def change
    create_table :evaluare_finalizata do |t|
      t.integer :id_curs
      t.integer :id_prof
      t.string :token
      t.string :grupa
      t.text :detalii
      t.integer :durata
      t.datetime :data_completare

      t.timestamps
    end
  end
end

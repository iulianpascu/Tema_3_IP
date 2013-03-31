class CreateEvaluareDisponibile < ActiveRecord::Migration
  def change
    create_table :evaluare_disponibile do |t|
      t.integer :curs_id
      t.integer :grupa_nume
      t.integer :formular_id
    end
  end
end

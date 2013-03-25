class CreateEvaluareInProgres < ActiveRecord::Migration
  def change
    create_table :evaluare_in_progres do |t|
      t.string :token
      t.datetime :incepere_sesiune

      t.timestamps
    end
  end
end

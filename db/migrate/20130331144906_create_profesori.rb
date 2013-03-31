class CreateProfesori < ActiveRecord::Migration
  def change
    create_table :profesori do |t|
      t.string :nume
      t.string :prenume
    end
  end
end

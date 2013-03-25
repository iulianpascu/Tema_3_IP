class CreateProfesors < ActiveRecord::Migration
  def change
    create_table :profesors do |t|
      t.integer :id_prof
      t.string :nume_prof

      t.timestamps
    end
  end
end

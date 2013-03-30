class CreateCurs < ActiveRecord::Migration
  def change
    #drop_table :curs

    create_table :curs do |t|
      t.integer :id_curs
      t.string :nume_curs
      t.string :tip_curs

      t.timestamps
    end
  end
end

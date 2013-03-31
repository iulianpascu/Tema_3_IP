class CreateGrupas < ActiveRecord::Migration
  def change
    create_table :grupe do |t|
      t.integer :nume
      t.integer :studenti
      t.boolean :terminal

      # t.timestamps
    end
  end
end

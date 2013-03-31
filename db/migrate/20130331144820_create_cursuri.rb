class CreateCursuri < ActiveRecord::Migration
  def change
    create_table :cursuri do |t|
      t.string :nume
      t.string :tip
      t.integer :profesor_id
    end
  end
end

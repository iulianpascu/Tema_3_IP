class CreateGrupas < ActiveRecord::Migration
  def change
    create_table :grupas do |t|
      t.string :grupa
      t.integer :studenti

      t.timestamps
    end
  end
end

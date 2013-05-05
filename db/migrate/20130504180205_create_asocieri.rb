class CreateAsocieri < ActiveRecord::Migration
  def change
    create_table :asocieri do |t|
      t.integer :curs_id
      t.integer :grupa_id
      t.integer :an
      t.integer :semestru
    end
  end
end

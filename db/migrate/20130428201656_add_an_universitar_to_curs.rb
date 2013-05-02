class AddAnUniversitarToCurs < ActiveRecord::Migration
  def change
    add_column :cursuri, :an_universitar, :integer
  end
end

class AddSpecializareToCurs < ActiveRecord::Migration
  def change
    add_column :cursuri, :specializare, :string
  end
end
